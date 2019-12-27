module Mydumper
  module Runtime
    module Middleware
      class CreateDirectories < Mydumper::Runtime::Middleware::Base
        def call(job, ctx) : Bool
          logger.info { "#{self.class.name}" }

          with_context(ctx) do
            create_directory(job.database.backup_dir) && create_directory(job.database.tables_dir)
          end
        end
      end
    end
  end
end
