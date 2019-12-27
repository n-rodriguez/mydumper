require "../../spec_helper.cr"

describe Mydumper::Config::Credentials do
  describe ".from_yaml" do
    it "loads yaml config from file" do
      generated_config = File.read("spec/fixtures/config/credentials/default.dumped.yml")
      config = Mydumper::Spec.build_credentials_config_object

      YAML.dump(config).should eq generated_config
    end
  end

  describe "#host" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_credentials_config_object

      config.host.should eq "127.0.0.1"
    end
  end

  describe "#port" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_credentials_config_object

      config.port.should eq "3306"
    end
  end

  describe "#user" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_credentials_config_object

      config.user.should eq "root"
    end
  end

  describe "#pass" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_credentials_config_object

      config.pass.should eq "root"
    end
  end
end
