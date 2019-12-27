require "./spec_helper.cr"

describe Mydumper do
  describe ".redis_config" do
    it "returns Redis config as a tuple" do
      config = Mydumper::Spec.build_global_config_object
      Mydumper.config = config

      Mydumper.redis_config.should eq({hostname: "127.0.0.1", port: 6379, db: 1, pool_size: 4, password: nil})
    end
  end

  describe ".sidekiq_concurrency" do
    it "returns Sidekiq concurrency config as an Int" do
      config = Mydumper::Spec.build_global_config_object
      Mydumper.config = config

      Mydumper.sidekiq_concurrency.should eq 2
    end
  end
end
