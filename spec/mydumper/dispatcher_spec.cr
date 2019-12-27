require "../spec_helper.cr"

describe Mydumper::Dispatcher do
  describe "#valid_jobs" do
    it "returns a list of valid jobs" do
      dispatcher = Mydumper::Spec.build_dispatcher_object

      dispatcher.valid_jobs.class.should eq Array(Mydumper::AsyncJob)
      dispatcher.valid_jobs.size.should eq 1
      job = dispatcher.valid_jobs.first
      job.name.should eq "Daily Backup - localhost"
    end
  end

  describe "#invalid_jobs" do
    it "returns a list of invalid jobs" do
      dispatcher = Mydumper::Spec.build_dispatcher_object

      dispatcher.invalid_jobs.class.should eq Array(Mydumper::AsyncJob)
      dispatcher.invalid_jobs.size.should eq 1
      job = dispatcher.invalid_jobs.first
      job.name.should eq "Daily Backup - mysql.example.corp"
    end
  end
end
