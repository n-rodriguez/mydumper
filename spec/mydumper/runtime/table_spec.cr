require "../../spec_helper.cr"

describe Mydumper::Runtime::Table do
  describe "#name" do
    it "returns table name" do
      table = Mydumper::Spec.build_runtime_table_object

      table.name.should eq("foo")
    end
  end

  describe "#full_name" do
    it "returns table path" do
      table = Mydumper::Spec.build_runtime_table_object

      table.full_name.should eq("my_db_name.foo")
    end
  end

  describe "#path_to_table" do
    it "returns path to table files prefix" do
      table = Mydumper::Spec.build_runtime_table_object

      table.path_to_table.should eq("/data/mysql-backup/localhost/daily/my_db_name/tables/foo")
    end
  end

  describe "#schema_file" do
    it "returns path to schema file" do
      table = Mydumper::Spec.build_runtime_table_object

      table.schema_file.should eq("/data/mysql-backup/localhost/daily/my_db_name/tables/foo.schema.sql")
    end
  end

  describe "#data_file" do
    it "returns path to data file" do
      table = Mydumper::Spec.build_runtime_table_object

      table.data_file.should eq("/data/mysql-backup/localhost/daily/my_db_name/tables/foo.data.sql")
    end
  end

  describe "#dump_schema_args" do
    it "returns dump_schema args" do
      table = Mydumper::Spec.build_runtime_table_object

      table.dump_schema_args.should eq(["--defaults-file=/data/mysql-backup/localhost/daily/my_db_name/credentials.cnf", "--max_allowed_packet=128M", "--opt", "--no-data", "--triggers", "--skip-lock-tables", "my_db_name", "foo"])
    end
  end

  describe "#dump_data_args" do
    it "returns dump_data args" do
      table = Mydumper::Spec.build_runtime_table_object

      table.dump_data_args.should eq(["--defaults-file=/data/mysql-backup/localhost/daily/my_db_name/credentials.cnf", "--max_allowed_packet=128M", "--opt", "--no-create-info", "--skip-triggers", "my_db_name", "foo"])
    end
  end
end
