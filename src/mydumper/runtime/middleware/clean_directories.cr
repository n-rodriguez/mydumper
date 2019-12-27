module Mydumper
  module Runtime
    module Middleware
      class CleanDirectories < Mydumper::Runtime::Middleware::Base
        def call(job, ctx) : Bool
          logger.info { "#{self.class.name}" }

          with_context(ctx) do
            delete_directory(job.database.backup_dir)
          end
        end
      end
    end
  end
end
