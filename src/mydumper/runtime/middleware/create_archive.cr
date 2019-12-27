module Mydumper
  module Runtime
    module Middleware
      class CreateArchive < Mydumper::Runtime::Middleware::Base
        def call(job, ctx) : Bool
          logger.info { "#{self.class.name}" }

          with_context(ctx) do
            create_archive(job)
          end
        end

        private def create_archive(job)
          file = job.archive_file
          args = job.create_archive_args

          logger.info { " * Creating tar archive: #{file}" }

          exit_code, output = Mydumper::Utils::Command.tar(args)

          if exit_code != 0
            ex = Exception.new(output.to_s)
            logger.error(exception: ex) { " * Error while creating tar archive: #{file}" }
          else
            logger.info { " * Tar archive created: #{file}" }
          end

          exit_code == 0
        end
      end
    end
  end
end
