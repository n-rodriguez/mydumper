require "../spec_helper.cr"

describe Mydumper::AsyncJob do
  describe "#databases" do
    it "returns a list of filtered databases" do
      job = Mydumper::Spec.build_job_object

      job.databases.class.should eq Array(Mydumper::Config::Database)
      database = job.databases.first
      database.db_name.should eq "my_db_name"
    end
  end

  describe "#skipped_databases" do
    it "returns a list of skipped databases" do
      job = Mydumper::Spec.build_job_object

      job.skipped_databases.should eq ["performance_schema", "information_schema", "mysql"]
    end
  end

  describe "#to_hash" do
    it "returns a hash representation of the job" do
      job = Mydumper::Spec.build_job_object

      job.to_hash.should eq({
        "name"               => "Daily Backup - localhost",
        "vault"              => "localhost/daily",
        "mysql_host"         => "localhost",
        "mysql_port"         => "3306",
        "mysql_user"         => "root",
        "mysql_pass"         => "root",
        "show_tables_query"  => "SHOW TABLES",
        "max_allowed_packet" => "128M",
        "backup_dir"         => "/data/mysql-backup",
        "databases"          => ["my_db_name"],
        "skip_databases"     => ["performance_schema", "information_schema", "mysql"],
      })
    end
  end
end
