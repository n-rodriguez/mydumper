module Mydumper
  module Runtime
    class Table
      getter name : String
      getter full_name : String

      def initialize(@name : String, @database : Mydumper::Runtime::Database)
        @full_name = "#{@database.name}.#{@name}"
      end

      def path_to_table : String
        File.join(@database.tables_dir, @name)
      end

      def schema_file : String
        "#{path_to_table}.schema.sql"
      end

      def data_file : String
        "#{path_to_table}.data.sql"
      end

      def dump_schema_args : Array(String)
        [
          "--defaults-file=#{@database.credentials_file}",
          "--max_allowed_packet=#{@database.max_allowed_packet}",
          "--opt",
          "--no-data",
          "--triggers",
          "--skip-lock-tables",
          "#{@database.name}",
          "#{@name}",
        ]
      end

      def dump_data_args : Array(String)
        [
          "--defaults-file=#{@database.credentials_file}",
          "--max_allowed_packet=#{@database.max_allowed_packet}",
          "--opt",
          "--no-create-info",
          "--skip-triggers",
          "#{@database.name}",
          "#{@name}",
        ]
      end

      def to_hash
        {
          "name"   => name,
          "schema" => schema_file,
          "data"   => data_file,
        }
      end

      def to_yaml(yaml)
        to_hash.to_yaml(yaml)
      end
    end
  end
end
