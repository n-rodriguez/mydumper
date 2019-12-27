module Mydumper
  module Runtime
    module Middleware
      class CreateCredentialsFile < Mydumper::Runtime::Middleware::Base
        def call(job, ctx) : Bool
          logger.info { "#{self.class.name}" }

          with_context(ctx) do
            create_ini_file(job.database.credentials_file, job.database.credentials_data)
          end
        end

        private def create_ini_file(file, data) : Bool
          ini = INI.build({"client" => data})
          create_file(file, ini, 0o600)
        end
      end
    end
  end
end
