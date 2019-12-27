module Mydumper
  module Runtime
    module Middleware
      class DumpGlobalSchema < Mydumper::Runtime::Middleware::Base
        def call(job, ctx) : Bool
          logger.info { "#{self.class.name}" }

          with_context(ctx) do
            dump_global_schema(job)
          end
        end

        private def dump_global_schema(job)
          file = job.database.schema_file
          args = job.database.dump_schema_args

          logger.info { " * Dumping database schema: #{file}" }

          exit_code, output = Mydumper::Utils::Command.dump(args, file)

          if exit_code != 0
            ex = Exception.new(output.to_s)
            logger.error(exception: ex) { " * Error while dumping database schema: #{file}" }
          else
            logger.info { " * Database schema dumped: #{file}" }
          end

          exit_code == 0
        end
      end
    end
  end
end
