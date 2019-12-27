module Mydumper
  module Config
    class Job < Base
      DEFAULT_CRON     = "* * * * *"
      BACKUP_DATABASES = "auto"

      property name : String
      property vault : String
      property run_at : String = DEFAULT_CRON
      property credentials : Credentials
      property backup_databases : String | Array(String) = BACKUP_DATABASES
      property skip_databases : Array(String) = [] of String
      property show_tables_query : String = "SHOW TABLES"
      property max_allowed_packet : String = "128M"

      @databases : Array(Mydumper::Config::Database)?

      def backup_all_databases? : Bool
        return false if backup_databases.is_a?(Array)

        backup_databases.as(String).downcase == BACKUP_DATABASES
      end

      def databases : Array(Mydumper::Config::Database)
        @databases ||= build_databases(find_method)
      end

      def database_options : Hash(String, String)
        {
          "mysql_host"         => mysql_host,
          "mysql_port"         => mysql_port,
          "mysql_user"         => mysql_user,
          "mysql_pass"         => mysql_pass,
          "show_tables_query"  => show_tables_query,
          "max_allowed_packet" => max_allowed_packet,
        }
      end

      def mysql_host : String
        credentials.host
      end

      def mysql_port : String
        credentials.port
      end

      def mysql_user : String
        credentials.user
      end

      def mysql_pass : String
        credentials.pass
      end

      def run_all_time? : Bool
        run_at == DEFAULT_CRON
      end

      private def build_databases(dbs : Array(String)) : Array(Mydumper::Config::Database)
        dbs.map do |db|
          options = database_options.dup
          options = options.merge({"db_name" => db})
          Mydumper::Config::Database.from_yaml(options.to_yaml)
        end
      end

      private def find_method : Array(String)
        backup_all_databases? ? dynamic_databases_list : static_databases_list
      end

      private def dynamic_databases_list : Array(String)
        url = Mydumper::Utils::DB.build_mysql_url({mysql_host: mysql_host, mysql_port: mysql_port, mysql_user: mysql_user, mysql_pass: mysql_pass, db_name: "mysql"})

        begin
          Mydumper::Utils::DB.show_databases(url)
        rescue e : Exception
          [] of String
        end
      end

      private def static_databases_list : Array(String)
        backup_databases.as(Array(String))
      end
    end
  end
end
