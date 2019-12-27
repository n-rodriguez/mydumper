require "../../spec_helper.cr"

describe Mydumper::Config::Global do
  describe ".from_yaml" do
    it "loads yaml config from file" do
      generated_config = File.read("spec/fixtures/config/global/default.dumped.yml")
      config = Mydumper::Spec.build_global_config_object(file: "spec/fixtures/config/global/with_secret.yml")

      YAML.dump(config).should eq generated_config
    end
  end

  describe "#log_file" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_global_config_object

      config.log_file.should eq "./log/mydumper.log"
    end
  end

  describe "#log_level" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_global_config_object

      config.log_level.should eq "debug"
    end
  end

  describe "#backup_dir" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_global_config_object

      config.backup_dir.should eq "/data/mysql-backup"
    end
  end

  describe "#jobs" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_global_config_object

      config.jobs.class.should eq Array(Mydumper::Config::Job)
      job1 = config.jobs.first
      job1.name.should eq "Daily Backup - localhost"
    end
  end

  describe "#skip_databases" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_global_config_object

      config.skip_databases.should eq ["performance_schema", "information_schema", "mysql"]
    end
  end
end
