module Mydumper
  class Dispatcher
    getter valid_jobs : Array(Mydumper::AsyncJob) = [] of Mydumper::AsyncJob
    getter invalid_jobs : Array(Mydumper::AsyncJob) = [] of Mydumper::AsyncJob

    @jobs : Array(Mydumper::Config::Job)

    def initialize(@global_config : Mydumper::Config::Global)
      @jobs = @global_config.jobs

      load_jobs!
    end

    private def load_jobs!
      @jobs.each do |job_config|
        job = Mydumper::AsyncJob.new(@global_config, job_config)

        if job.valid?
          @valid_jobs << job
        else
          @invalid_jobs << job
        end
      end
    end
  end
end
