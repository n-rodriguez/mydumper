module Mydumper
  module Runtime
    module Middleware
      class CreateRestoreScript < Mydumper::Runtime::Middleware::Base
        def call(job, ctx) : Bool
          logger.info { "#{self.class.name}" }

          with_context(ctx) do
            create_file(job.database.restore_file, job.database.restore_data, 0o755)
          end
        end
      end
    end
  end
end
