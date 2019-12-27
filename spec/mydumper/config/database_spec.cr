require "../../spec_helper.cr"

describe Mydumper::Config::Database do
  describe ".from_yaml" do
    it "loads yaml config from file" do
      generated_config = File.read("spec/fixtures/config/database/default.dumped.yml")
      config = Mydumper::Spec.build_database_config_object

      YAML.dump(config).should eq generated_config
    end
  end

  describe "#db_name" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_database_config_object

      config.db_name.should eq "my_db_name"
    end
  end

  describe "#mysql_host" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_database_config_object

      config.mysql_host.should eq "localhost"
    end
  end

  describe "#mysql_port" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_database_config_object

      config.mysql_port.should eq "3306"
    end
  end

  describe "#mysql_user" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_database_config_object

      config.mysql_user.should eq "root"
    end
  end

  describe "#mysql_pass" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_database_config_object

      config.mysql_pass.should eq "root"
    end
  end

  describe "#show_tables_query" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_database_config_object

      config.show_tables_query.should eq "SHOW TABLES"
    end
  end

  describe "#max_allowed_packet" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_database_config_object

      config.max_allowed_packet.should eq "128M"
    end
  end

  describe "#tables" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_database_config_object

      config.tables.should eq ["table1", "table2"]
    end
  end

  describe "#to_hash" do
    it "returns a hash representation" do
      config = Mydumper::Spec.build_database_config_object

      config.to_hash.should eq({
        "db_name"            => "my_db_name",
        "mysql_host"         => "localhost",
        "mysql_port"         => "3306",
        "mysql_user"         => "root",
        "mysql_pass"         => "root",
        "show_tables_query"  => "SHOW TABLES",
        "max_allowed_packet" => "128M",
        "tables"             => ["table1", "table2"],
      })
    end
  end
end
