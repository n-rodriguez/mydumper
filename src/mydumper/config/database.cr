module Mydumper
  module Config
    class Database < Base
      property db_name : String
      property mysql_host : String
      property mysql_port : String
      property mysql_user : String
      property mysql_pass : String
      property show_tables_query : String
      property max_allowed_packet : String

      @tables : Array(String)?

      def tables
        @tables ||= find_tables
      end

      def to_hash
        super.merge({"tables" => tables})
      end

      private def find_tables
        url = build_mysql_url
        query = show_tables_query.dup
        query = query % {db_name: db_name, percent: "%"}
        Mydumper::Utils::DB.show_tables(url, query)
      end

      private def build_mysql_url : String
        Mydumper::Utils::DB.build_mysql_url({mysql_host: mysql_host, mysql_port: mysql_port, mysql_user: mysql_user, mysql_pass: mysql_pass, db_name: db_name})
      end
    end
  end
end
