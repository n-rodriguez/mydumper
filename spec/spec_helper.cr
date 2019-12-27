require "spec"
require "timecop"
require "crystal-env/spec"

require "../src/mydumper"

module Mydumper::Spec
  def self.build_dispatcher_object
    Mydumper::Dispatcher.new(build_global_config_object)
  end

  def self.build_job_object
    Mydumper::AsyncJob.new(build_global_config_object, build_job_config_object)
  end

  def self.build_global_config_object(file = "spec/fixtures/config/global/default.yml")
    load_yaml(Mydumper::Config::Global, file)
  end

  def self.build_job_config_object(file = "spec/fixtures/config/job/default.yml")
    load_yaml(Mydumper::Config::Job, file)
  end

  def self.build_job_config_object_with_auto_backup(file = "spec/fixtures/config/job/auto_backup.yml")
    build_job_config_object(file)
  end

  def self.build_database_config_object(file = "spec/fixtures/config/database/default.yml")
    load_yaml(Mydumper::Config::Database, file)
  end

  def self.build_credentials_config_object(file = "spec/fixtures/config/credentials/default.yml")
    load_yaml(Mydumper::Config::Credentials, file)
  end

  def self.load_yaml(klass, file)
    klass.from_yaml(File.read(file))
  end

  def self.build_runtime_job_object(config = runtime_job_full_config)
    Mydumper::Runtime::Job.new(config)
  end

  def self.build_runtime_database_object(config = runtime_database_config)
    job = build_runtime_job_object(runtime_job_small_config)
    Mydumper::Runtime::Database.new(job, config)
  end

  def self.build_runtime_table_object(name = "foo", database = build_runtime_database_object)
    Mydumper::Runtime::Table.new(name, database)
  end

  def self.runtime_job_full_config
    {
      "job_name"           => "Daily Backup - localhost",
      "backup_dir"         => "/data/mysql-backup",
      "vault"              => "localhost/daily",
      "db_name"            => "my_db_name",
      "mysql_host"         => "localhost",
      "mysql_port"         => "3306",
      "mysql_user"         => "root",
      "mysql_pass"         => "root",
      "show_tables_query"  => "SHOW TABLES",
      "max_allowed_packet" => "128M",
      "tables"             => [
        "foo",
        "bar",
      ],
    }
  end

  def self.runtime_job_small_config
    config = Hash(String, String | Array(String)).new
    config["job_name"] = "Daily Backup - localhost"
    config["backup_dir"] = "/data/mysql-backup"
    config["vault"] = "localhost/daily"
    config
  end

  def self.runtime_database_config
    {
      "db_name"            => "my_db_name",
      "mysql_host"         => "localhost",
      "mysql_port"         => "3306",
      "mysql_user"         => "root",
      "mysql_pass"         => "root",
      "show_tables_query"  => "SHOW TABLES",
      "max_allowed_packet" => "128M",
      "tables"             => [
        "foo",
        "bar",
      ],
    }
  end
end
