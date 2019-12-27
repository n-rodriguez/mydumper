module Mydumper
  module Runtime
    module Middleware
      abstract class Base < Mydumper::Runtime::Middleware::Entry
        getter logger

        def initialize(@logger : ::Log)
        end

        private def with_context(ctx) : Bool
          result = yield
          ctx[self.class.name] = result ? "success" : "failure"
          result
        end

        private def dump_tables(database, dump_type) : Bool
          total_result = {} of String => Bool

          database.backup_tables.each_slice(4) do |tables_array|
            chan = Channel(NamedTuple(success: Bool)).new

            tables_array.each do |table|
              spawn do
                dump_table(dump_type, table, chan)
              end
            end

            tables_array.each do |table|
              result = chan.receive
              total_result[table.name] = result[:success]
            end
          end

          !total_result.values.includes?(false)
        end

        private def dump_table(dump_type, table, chan)
          logger.info { " * Dumping table #{dump_type}: #{table.full_name}" }

          case dump_type
          when :schema
            args = table.dump_schema_args
            file = table.schema_file
          when :data
            args = table.dump_data_args
            file = table.data_file
          end

          exit_code, output = Mydumper::Utils::Command.dump(args.not_nil!, file.not_nil!)

          if exit_code != 0
            ex = Exception.new(output.to_s)
            logger.error(exception: ex) { " * Error while dumping table #{dump_type}: #{table.full_name}" }
          else
            logger.info { " * Table #{dump_type} dumped: #{table.full_name}" }
          end

          message = ""

          chan.send({success: exit_code == 0})
        end

        private def create_directory(dir) : Bool
          logger.info { " * Creating directory: #{dir}" }

          begin
            FileUtils.mkdir_p(dir)
          rescue ex : Exception
            logger.error(exception: ex) { "Error while creating directory: #{dir}" }
            false
          else
            logger.info { " * Directory created: #{dir}" }
            true
          end
        end

        private def delete_directory(dir) : Bool
          logger.info { " * Deleting directory: #{dir}" }

          begin
            FileUtils.rm_rf(dir)
          rescue ex : Exception
            logger.error(exception: ex) { "Error while deleting directory: #{dir}" }
            false
          else
            logger.info { " * Directory deleted: #{dir}" }
            true
          end
        end

        private def create_file(file, data, perm) : Bool
          logger.info { " * Creating file: #{file}" }

          begin
            File.write(file, data, perm: perm)
          rescue ex : Exception
            logger.error(exception: ex) { "Error while creating file: #{file}" }
            false
          else
            logger.info { " * File created: #{file}" }
            true
          end
        end

        private def delete_file(file) : Bool
          logger.info { " * Deleting file: #{file}" }

          begin
            File.delete(file)
          rescue ex : Exception
            logger.error(exception: ex) { "Error while deleting file: #{file}" }
            false
          else
            logger.info { " * File deleted: #{file}" }
            true
          end
        end
      end
    end
  end
end
