require "../../spec_helper.cr"

describe Mydumper::Runtime::Database do
  describe "#tables" do
    it "returns a list of tables to backup" do
      database = Mydumper::Spec.build_runtime_database_object

      database.tables.should eq(["foo", "bar"])
    end
  end

  describe "#backup_tables" do
    it "returns a list of backup_tables to backup" do
      database = Mydumper::Spec.build_runtime_database_object

      database.backup_tables.class.should eq Array(Mydumper::Runtime::Table)
    end
  end

  describe "#backup_dir" do
    it "returns backup_dir" do
      database = Mydumper::Spec.build_runtime_database_object

      database.backup_dir.should eq("/data/mysql-backup/localhost/daily/my_db_name")
    end
  end

  describe "#tables_dir" do
    it "returns tables_dir" do
      database = Mydumper::Spec.build_runtime_database_object

      database.tables_dir.should eq("/data/mysql-backup/localhost/daily/my_db_name/tables")
    end
  end

  describe "#credentials_file" do
    it "returns credentials_file" do
      database = Mydumper::Spec.build_runtime_database_object

      database.credentials_file.should eq("/data/mysql-backup/localhost/daily/my_db_name/credentials.cnf")
    end
  end

  describe "#credentials_data" do
    it "returns credentials_data" do
      database = Mydumper::Spec.build_runtime_database_object

      database.credentials_data.should eq({"host" => "localhost", "port" => "3306", "user" => "root", "password" => "root"})
    end
  end

  describe "#schema_file" do
    it "returns path to schema file" do
      database = Mydumper::Spec.build_runtime_database_object

      database.schema_file.should eq("/data/mysql-backup/localhost/daily/my_db_name/global.schema.sql")
    end
  end

  describe "#dump_schema_args" do
    it "returns dump_schema args" do
      database = Mydumper::Spec.build_runtime_database_object

      database.dump_schema_args.should eq(["--defaults-file=/data/mysql-backup/localhost/daily/my_db_name/credentials.cnf", "--max_allowed_packet=128M", "--opt", "--no-data", "--triggers", "--skip-lock-tables", "my_db_name"])
    end
  end

  describe "#restore_file" do
    it "returns restore_file" do
      database = Mydumper::Spec.build_runtime_database_object

      database.restore_file.should eq("/data/mysql-backup/localhost/daily/my_db_name/restore.sh")
    end
  end

  describe "#restore_data" do
    it "returns restore_data" do
      database = Mydumper::Spec.build_runtime_database_object

      database.restore_data.should eq("#!/usr/bin/env bash\n\necho \"Restoring schema\"\nmysql my_db_name < global.schema.sql\n\nfor file in $(ls -1 tables/*.data.sql); do\n  echo -n \"Restoring ${file} ... \"\n  mysql my_db_name < ${file}\n  echo \"Done\"\ndone\n")
    end
  end

  describe "#mysql_host" do
    it "returns mysql_host" do
      database = Mydumper::Spec.build_runtime_database_object

      database.mysql_host.should eq("localhost")
    end
  end

  describe "#mysql_port" do
    it "returns mysql_port" do
      database = Mydumper::Spec.build_runtime_database_object

      database.mysql_port.should eq("3306")
    end
  end

  describe "#mysql_user" do
    it "returns mysql_user" do
      database = Mydumper::Spec.build_runtime_database_object

      database.mysql_user.should eq("root")
    end
  end

  describe "#mysql_pass" do
    it "returns mysql_pass" do
      database = Mydumper::Spec.build_runtime_database_object

      database.mysql_pass.should eq("root")
    end
  end

  describe "#show_tables_query" do
    it "returns show_tables_query" do
      database = Mydumper::Spec.build_runtime_database_object

      database.show_tables_query.should eq("SHOW TABLES")
    end
  end

  describe "#max_allowed_packet" do
    it "returns max_allowed_packet" do
      database = Mydumper::Spec.build_runtime_database_object

      database.max_allowed_packet.should eq("128M")
    end
  end
end
