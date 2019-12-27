module Mydumper
  module Runtime
    class Database
      @name : String
      @tables : Array(String)

      getter name
      getter tables

      @mysql_host : String
      @mysql_port : String
      @mysql_user : String
      @mysql_pass : String

      getter mysql_host
      getter mysql_port
      getter mysql_user
      getter mysql_pass

      @show_tables_query : String
      @max_allowed_packet : String

      getter show_tables_query
      getter max_allowed_packet

      @backup_tables : Array(Mydumper::Runtime::Table)?

      def initialize(@job : Mydumper::Runtime::Job, @config : Hash(String, Array(String) | String))
        @name = @config["db_name"].as(String)
        @tables = @config["tables"].as(Array(String))

        @mysql_host = @config["mysql_host"].as(String)
        @mysql_port = @config["mysql_port"].as(String)
        @mysql_user = @config["mysql_user"].as(String)
        @mysql_pass = @config["mysql_pass"].as(String)

        @show_tables_query = @config["show_tables_query"].as(String)
        @max_allowed_packet = @config["max_allowed_packet"].as(String)
      end

      def to_hash
        {
          "backup_dir"         => backup_dir,
          "tables_dir"         => tables_dir,
          "credentials_file"   => credentials_file,
          "restore_file"       => restore_file,
          "mysql_host"         => mysql_host,
          "mysql_port"         => mysql_port,
          "mysql_user"         => mysql_user,
          "mysql_pass"         => mysql_pass,
          "show_tables_query"  => show_tables_query,
          "max_allowed_packet" => max_allowed_packet,
          "tables"             => backup_tables,
        }
      end

      def backup_tables : Array(Mydumper::Runtime::Table)
        @backup_tables ||= build_tables(tables)
      end

      def backup_dir : String
        File.join(@job.base_dir, name)
      end

      def tables_dir : String
        File.join(backup_dir, "tables")
      end

      def credentials_file : String
        File.join(backup_dir, "credentials.cnf")
      end

      def credentials_data : Hash(String, String)
        {
          "host"     => mysql_host,
          "port"     => mysql_port,
          "user"     => mysql_user,
          "password" => mysql_pass,
        }
      end

      def schema_file : String
        File.join(backup_dir, "global.schema.sql")
      end

      def dump_schema_args : Array(String)
        [
          "--defaults-file=#{credentials_file}",
          "--max_allowed_packet=#{max_allowed_packet}",
          "--opt",
          "--no-data",
          "--triggers",
          "--skip-lock-tables",
          "#{name}",
        ]
      end

      def restore_file : String
        File.join(backup_dir, "restore.sh")
      end

      def restore_data : String
        @restore_data ||= <<-STRING
        #!/usr/bin/env bash

        echo "Restoring schema"
        mysql #{name} < global.schema.sql

        for file in $(ls -1 tables/*.data.sql); do
          echo -n "Restoring ${file} ... "
          mysql #{name} < ${file}
          echo "Done"
        done

        STRING
      end

      def to_yaml(yaml)
        to_hash.to_yaml(yaml)
      end

      private def build_tables(tables : Array(String)) : Array(Mydumper::Runtime::Table)
        tables.map { |t| Mydumper::Runtime::Table.new(t, self) }
      end
    end
  end
end
