module Mydumper
  module Utils
    module DB
      def self.build_mysql_url(opts) : String
        "mysql://#{opts[:mysql_user]}:#{opts[:mysql_pass]}@#{opts[:mysql_host]}:#{opts[:mysql_port]}/#{opts[:db_name]}"
      end

      def self.show_databases(url : String) : Array(String)
        databases = [] of String
        ::DB.open url do |db|
          db.query "SHOW DATABASES" do |rs|
            rs.each do
              database = rs.read(String)
              databases << database
            end
          end
        end
        databases
      end

      def self.show_tables(url : String, show_query : String) : Array(String)
        tables = [] of String
        ::DB.open url do |db|
          db.query show_query do |rs|
            rs.each do
              table = rs.read(String)
              tables << table
            end
          end
        end
        tables
      end
    end
  end
end
