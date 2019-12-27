module Mydumper
  class Worker
    include Sidekiq::Worker

    sidekiq_options do |job|
      job.retry = false
    end

    def perform(opts : Hash(String, Array(String) | String))
      job = Mydumper::Runtime::Job.new(opts)

      begin
        job_logger = build_job_logger(job)
      rescue ex : Exception
        logger.error(exception: ex) { "Error while instantiating job logger" }
      else
        logger.info { "Start backup job: #{job.id}" }
        success = Mydumper::Runtime::Dumper.run(job, job_logger)

        if success
          logger.info { "Done backup job: #{job.id}" }
        else
          logger.error { "Errors happened during backup job: #{job.id}" }
        end
      end
    end

    private def build_job_logger(job)
      target = job.id
      log_file = job.log_file
      log_dir = File.dirname(log_file)

      FileUtils.mkdir_p(log_dir)

      log_target = File.open(log_file, "a")
      log_target.flush_on_newline = true

      ::Log.builder.bind(target, :info, Sidekiq::Logger::PrettyBackend.new(log_target))
      ::Log.for(target)
    end
  end
end
