require "../../spec_helper.cr"

describe Mydumper::Config::Job do
  describe ".from_yaml" do
    it "loads yaml config from file and use default values" do
      generated_config = File.read("spec/fixtures/config/job/default.dumped.yml")
      config = Mydumper::Spec.build_job_config_object

      YAML.dump(config).should eq generated_config
    end

    it "loads yaml config from file and use custom values" do
      generated_config = File.read("spec/fixtures/config/job/auto_backup.dumped.yml")
      config = Mydumper::Spec.build_job_config_object_with_auto_backup

      YAML.dump(config).should eq generated_config
    end
  end

  describe "#name" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.name.should eq "Daily Backup - localhost"
    end
  end

  describe "#vault" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.vault.should eq "localhost/daily"
    end
  end

  describe "#run_at" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.run_at.should eq "* * * * *"
    end
  end

  describe "#credentials" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.credentials.host.should eq "localhost"
      config.credentials.port.should eq "3306"
      config.credentials.user.should eq "root"
      config.credentials.pass.should eq "root"
    end
  end

  describe "#show_tables_query" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.show_tables_query.should eq "SHOW TABLES"
    end
  end

  describe "#max_allowed_packet" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.max_allowed_packet.should eq "128M"
    end
  end

  describe "#mysql_host" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.mysql_host.should eq "localhost"
    end
  end

  describe "#mysql_port" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.mysql_port.should eq "3306"
    end
  end

  describe "#mysql_user" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.mysql_user.should eq "root"
    end
  end

  describe "#mysql_pass" do
    it "returns value loaded from yaml file" do
      config = Mydumper::Spec.build_job_config_object

      config.mysql_pass.should eq "root"
    end
  end

  describe "#database_options" do
    it "returns a hash of options to build Mydumper::Config::Database object" do
      config = Mydumper::Spec.build_job_config_object

      config.database_options.should eq({
        "mysql_host"         => "localhost",
        "mysql_port"         => "3306",
        "mysql_user"         => "root",
        "mysql_pass"         => "root",
        "show_tables_query"  => "SHOW TABLES",
        "max_allowed_packet" => "128M",
      })
    end
  end

  context "when backup_databases is a list of databases" do
    describe "#backup_databases" do
      it "returns value loaded from yaml file" do
        config = Mydumper::Spec.build_job_config_object

        config.backup_databases.should eq ["my_db_name"]
      end
    end

    describe "#skip_databases" do
      it "returns value loaded from yaml file" do
        config = Mydumper::Spec.build_job_config_object

        config.skip_databases.should eq [] of String
      end
    end

    describe "#backup_all_databases?" do
      it "returns false" do
        config = Mydumper::Spec.build_job_config_object

        config.backup_all_databases?.should eq false
      end
    end

    describe "#databases" do
      it "returns a list of databases to backup" do
        config = Mydumper::Spec.build_job_config_object

        config.databases.class.should eq Array(Mydumper::Config::Database)
        db_names = config.databases.map(&.db_name)
        db_names.should eq ["my_db_name"]
      end
    end
  end

  context "when backup_databases == 'auto'" do
    describe "#backup_databases" do
      it "returns value loaded from yaml file" do
        config = Mydumper::Spec.build_job_config_object_with_auto_backup

        config.backup_databases.should eq "auto"
      end
    end

    describe "#skip_databases" do
      it "returns value loaded from yaml file" do
        config = Mydumper::Spec.build_job_config_object_with_auto_backup

        config.skip_databases.should eq ["performance_schema", "information_schema", "mysql"]
      end
    end

    describe "#backup_all_databases?" do
      it "returns true" do
        config = Mydumper::Spec.build_job_config_object_with_auto_backup

        config.backup_all_databases?.should eq true
      end
    end

    describe "#databases" do
      it "returns a list of databases to backup" do
        config = Mydumper::Spec.build_job_config_object_with_auto_backup

        config.databases.class.should eq Array(Mydumper::Config::Database)
        db_names = config.databases.map(&.db_name)
        db_names.should eq ["bar", "foo", "information_schema", "my_db_name", "mysql", "performance_schema"]
      end
    end
  end
end
