module Mydumper
  module Runtime
    module Middleware
      class DumpTablesData < Mydumper::Runtime::Middleware::Base
        def call(job, ctx) : Bool
          logger.info { "#{self.class.name}" }

          with_context(ctx) do
            dump_tables(job.database, :data)
          end
        end
      end
    end
  end
end
