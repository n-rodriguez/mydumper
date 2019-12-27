module Mydumper
  class AsyncJob
    delegate backup_dir, to: @global_config

    delegate name, to: @job_config
    delegate vault, to: @job_config
    delegate mysql_host, to: @job_config
    delegate mysql_port, to: @job_config
    delegate mysql_user, to: @job_config
    delegate mysql_pass, to: @job_config

    @databases : Array(Mydumper::Config::Database)?
    @skipped_databases : Array(String)?

    def initialize(@global_config : Mydumper::Config::Global, @job_config : Mydumper::Config::Job)
      @databases = nil
      @skipped_databases = nil
      @run_at = nil
      @errors = [] of String
      validate_config!
    end

    def valid? : Bool
      @errors.empty?
    end

    def validation_message : String
      return "Config OK" if @errors.empty?

      @errors.join("\n")
    end

    def run : Bool
      databases.each { |db| Mydumper::Worker.async.perform(job_options(db)) }
      true
    end

    def run_at
      @run_at ||= CronParser.new(@job_config.run_at)
    end

    def next_tick : Time
      run_at.next(Time.local)
    end

    def databases : Array(Mydumper::Config::Database)
      @databases ||= filter_databases(@job_config.databases, skipped_databases)
    end

    def skipped_databases : Array(String)
      @skipped_databases ||= begin
        skip_databases = @global_config.skip_databases || [] of String
        skip_databases += @job_config.skip_databases || [] of String
        skip_databases.reject(&.empty?)
      end
    end

    def to_hash : Hash(String, String | Array(String))
      hash = @job_config.database_options.dup
      hash.merge({
        "name"           => name,
        "vault"          => vault,
        "backup_dir"     => backup_dir,
        "databases"      => databases.map(&.db_name),
        "skip_databases" => skipped_databases,
      })
    end

    def to_yaml(yaml)
      to_hash.to_yaml(yaml)
    end

    private def validate_config!
      valid_connection?
      valid_run_at?
    end

    private def valid_connection?
      url = Mydumper::Utils::DB.build_mysql_url({mysql_host: mysql_host, mysql_port: mysql_port, mysql_user: mysql_user, mysql_pass: mysql_pass, db_name: "mysql"})

      begin
        Mydumper::Utils::DB.show_databases(url)
      rescue e : Exception
        @errors << e.inspect
      end
    end

    private def valid_run_at?
      return if @job_config.run_all_time?

      tick = next_tick.to_s("%Y-%m-%d")
      @errors << "Cannot run job now (next tick: #{tick})" unless tick == Time.local.to_s("%Y-%m-%d")
    end

    private def filter_databases(databases, skipped_databases) : Array(Mydumper::Config::Database)
      stack = [] of Mydumper::Config::Database

      databases.each do |db|
        next if skipped_databases.includes?(db.db_name)

        stack << db
      end

      stack
    end

    private def job_options(db) : Hash(String, String | Array(String))
      db.to_hash.merge({"job_name" => name, "backup_dir" => backup_dir, "vault" => vault})
    end
  end
end
