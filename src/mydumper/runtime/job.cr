module Mydumper
  module Runtime
    class Job
      @name : String
      @backup_dir : String
      @vault : String
      @date : Time

      getter name
      getter backup_dir
      getter vault
      getter date

      @database : Mydumper::Runtime::Database?

      def initialize(@config : Hash(String, Array(String) | String))
        @name = @config["job_name"].as(String)
        @backup_dir = @config["backup_dir"].as(String)
        @vault = @config["vault"].as(String)
        @date = Time.local
      end

      def id : String
        "#{vault}/#{database.name}/#{date.to_unix}"
      end

      def title : String
        "#{name} - #{date.to_s("%Y-%m-%d %Hh%M")} - #{database.name}"
      end

      def database : Mydumper::Runtime::Database
        @database ||= build_database(@config)
      end

      def base_dir : String
        File.join(backup_dir, vault)
      end

      def base_filename : String
        "#{database.name}.#{date.to_s("%Y-%m-%d_%Hh%M")}.#{date.day_of_week}"
      end

      def log_filename : String
        "#{base_filename}.log"
      end

      def log_file : String
        File.join(base_dir, log_filename)
      end

      def archive_filename : String
        "#{base_filename}.tar.gz"
      end

      def archive_file : String
        File.join(base_dir, archive_filename)
      end

      def create_archive_args
        ["--create", "--gzip", "--file", archive_file, "--directory", base_dir, "./#{database.name}/"]
      end

      def to_hash
        {
          "name"         => name,
          "backup_dir"   => backup_dir,
          "vault"        => vault,
          "date"         => date,
          "base_dir"     => base_dir,
          "archive_file" => archive_file,
          "log_file"     => log_file,
          "database"     => database,
        }
      end

      def to_yaml(yaml)
        to_hash.to_yaml(yaml)
      end

      private def build_database(config)
        db_config = config.reject("job_name", "backup_dir", "vault")
        Mydumper::Runtime::Database.new(self, db_config)
      end
    end
  end
end
