require "../../spec_helper.cr"

# Mydumper::Runtime::Database holds the configuration needed
# to dump database during runtime (when the Sidekiq worker runs).
#
# This configuration is computed **before** sending the job to Sidekiq.
# by Mydumper::Config::* classes. So the "tables" value here represents
# the list of tables determined by Mydumper::Config::Database#tables

# ---
# job_name: Daily Backup - localhost
# backup_dir: /data/mysql-backup
# vault: localhost/daily
# db_name: bar
# host: localhost
# mysql_host: localhost
# mysql_port: "3306"
# mysql_user: root
# mysql_pass: root
# show_tables_query: SHOW TABLES
# max_allowed_packet: 128M
# tables:
# - table1
# - table2

describe Mydumper::Runtime::Job do
  describe "#name" do
    it "returns job name" do
      job = Mydumper::Spec.build_runtime_job_object

      job.name.should eq "Daily Backup - localhost"
    end
  end

  describe "#id" do
    it "returns job id" do
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        job.id.should eq "localhost/daily/my_db_name/1614142800"
      end
    end
  end

  describe "#backup_dir" do
    it "returns job backup_dir" do
      job = Mydumper::Spec.build_runtime_job_object

      job.backup_dir.should eq "/data/mysql-backup"
    end
  end

  describe "#base_dir" do
    it "returns job base_dir" do
      job = Mydumper::Spec.build_runtime_job_object

      job.base_dir.should eq "/data/mysql-backup/localhost/daily"
    end
  end

  describe "#vault" do
    it "returns job vault" do
      job = Mydumper::Spec.build_runtime_job_object

      job.vault.should eq "localhost/daily"
    end
  end

  describe "#database" do
    it "returns job database" do
      job = Mydumper::Spec.build_runtime_job_object

      job.database.class.should eq Mydumper::Runtime::Database
    end
  end

  describe "#date" do
    it "returns job date" do
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        job.date.to_s.should eq "2021-02-24 06:00:00 +01:00"
      end
    end
  end

  describe "#base_filename" do
    it "returns base_filename" do
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        job.base_filename.should eq("my_db_name.2021-02-24_06h00.Wednesday")
      end
    end
  end

  describe "#log_filename" do
    it "returns log_filename" do
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        job.log_filename.should eq("my_db_name.2021-02-24_06h00.Wednesday.log")
      end
    end
  end

  describe "#log_file" do
    it "returns log_file" do
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        job.log_file.should eq("/data/mysql-backup/localhost/daily/my_db_name.2021-02-24_06h00.Wednesday.log")
      end
    end
  end

  describe "#archive_filename" do
    it "returns archive_filename" do
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        job.archive_filename.should eq("my_db_name.2021-02-24_06h00.Wednesday.tar.gz")
      end
    end
  end

  describe "#archive_file" do
    it "returns archive_file" do
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        job.archive_file.should eq("/data/mysql-backup/localhost/daily/my_db_name.2021-02-24_06h00.Wednesday.tar.gz")
      end
    end
  end

  describe "#create_archive_args" do
    it "returns job create_archive_args" do
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        job.create_archive_args.should eq ["--create", "--gzip", "--file", "/data/mysql-backup/localhost/daily/my_db_name.2021-02-24_06h00.Wednesday.tar.gz", "--directory", "/data/mysql-backup/localhost/daily", "./my_db_name/"]
      end
    end
  end

  describe "#to_yaml" do
    it "returns job as hash" do
      generated_config = File.read("spec/fixtures/runtime/job.dumped.yml")
      time = Time.local(2021, 2, 24, 6, 0, 0)
      Timecop.freeze(time) do
        job = Mydumper::Spec.build_runtime_job_object

        YAML.dump(job).should eq generated_config
      end
    end
  end
end
