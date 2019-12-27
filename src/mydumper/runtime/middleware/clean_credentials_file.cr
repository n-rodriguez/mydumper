module Mydumper
  module Runtime
    module Middleware
      class CleanCredentialsFile < Mydumper::Runtime::Middleware::Base
        def call(job, ctx) : Bool
          logger.info { "#{self.class.name}" }

          with_context(ctx) do
            delete_file(job.database.credentials_file)
          end
        end
      end
    end
  end
end
