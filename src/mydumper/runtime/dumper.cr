module Mydumper
  module Runtime
    class Dumper
      getter logger : ::Log
      getter middlewares : Mydumper::Runtime::Middleware::Chain(Mydumper::Runtime::Middleware::Base)

      MIDDLEWARES = [
        Mydumper::Runtime::Middleware::CreateDirectories,
        Mydumper::Runtime::Middleware::CreateCredentialsFile,
        Mydumper::Runtime::Middleware::DumpGlobalSchema,
        Mydumper::Runtime::Middleware::DumpTablesSchema,
        Mydumper::Runtime::Middleware::DumpTablesData,
        Mydumper::Runtime::Middleware::CleanCredentialsFile,
        Mydumper::Runtime::Middleware::CreateRestoreScript,
        Mydumper::Runtime::Middleware::CreateArchive,
        Mydumper::Runtime::Middleware::CleanDirectories,
      ]

      def self.run(job : Mydumper::Runtime::Job, logger : ::Log)
        new(logger).run(job)
      end

      def initialize(@logger : ::Log)
        @middlewares = Mydumper::Runtime::Middleware::Chain(Mydumper::Runtime::Middleware::Base).new.tap do |c|
          MIDDLEWARES.each do |klass|
            c.add klass.new(@logger)
          end
        end
      end

      def run(job : Mydumper::Runtime::Job) : Bool
        logger.info { "### START DB BACKUP | #{job.id} ###" }

        new_context = build_context

        success = middlewares.invoke(job, new_context)

        logger.info { "### END DB BACKUP | #{job.id} ###" }

        sleep 1

        send_email(job, success, new_context)

        success
      end

      def build_context : Hash(String, String)
        new_context = Hash(String, String).new
        MIDDLEWARES.each do |klass|
          new_context[klass.to_s] = "not_run"
        end
        new_context
      end

      def send_email(job : Mydumper::Runtime::Job, success : Bool, ctx : Hash(String, String))
        email = EMail::Message.new
        email.from Mydumper.config.email.from
        email.to Mydumper.config.email.to

        title = success ? "success" : "failure"
        email.subject "#{job.title} - #{title}"
        email.message YAML.dump(ctx)
        email.attach job.log_file

        config = EMail::Client::Config.new(Mydumper.config.email.smtp_host, Mydumper.config.email.smtp_port)

        # Create SMTP client object
        client = EMail::Client.new(config)

        # Send email
        client.start do
          send(email)
        end
      end
    end
  end
end
