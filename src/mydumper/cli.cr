module Mydumper
  # :nodoc:
  class CLI < Admiral::Command
    class Config < Admiral::Command
      define_help description: "Dump Mydumper configuration"

      define_flag config : String,
        description: "Path to config file",
        long: "config",
        short: "c",
        default: "mydumper.yml"

      def run
        Mydumper.load_config(flags.config)
        Mydumper.setup_log

        puts YAML.dump(Mydumper.config)
      end
    end

    class Check < Admiral::Command
      define_help description: "Check Mydumper jobs"

      define_flag config : String,
        description: "Path to config file",
        long: "config",
        short: "c",
        default: "mydumper.yml"

      def run
        Mydumper.load_config(flags.config)
        Mydumper.setup_log

        dispatcher = Mydumper.load_dispatcher!
        render_config_validation(dispatcher)
      end

      private def render_config_validation(dispatcher)
        table = TerminalTable.new
        table.headings = ["Job", "Runnable", "Vault", "Next tick", "Config", "Messages"]
        table.separate_rows = true

        dispatcher.valid_jobs.each do |job|
          table << [job.name, to_icon(job.valid?), job.vault, job.next_tick.to_s("%Y-%m-%d"), YAML.dump(job.to_hash), job.validation_message]
        end

        dispatcher.invalid_jobs.each do |job|
          table << [job.name, to_icon(job.valid?), job.vault, job.next_tick.to_s("%Y-%m-%d"), YAML.dump(job.to_hash), job.validation_message]
        end

        puts table.render
      end

      private def to_icon(bool)
        icon = bool ? "✔".colorize(:green) : "✗".colorize(:red)
        icon.to_s
      end
    end

    class Runner < Admiral::Command
      define_help description: "Launch Mydumper jobs"

      define_flag config : String,
        description: "Path to config file",
        long: "config",
        short: "c",
        default: "mydumper.yml"

      def run
        Mydumper.load_config(flags.config)
        Mydumper.setup_log
        Mydumper.start_mydumper_runner!

        dispatcher = Mydumper.load_dispatcher!
        launch_valid_jobs(dispatcher)
      end

      private def launch_valid_jobs(dispatcher)
        table = TerminalTable.new
        table.headings = ["Job", "Launched", "Config", "Messages"]
        table.separate_rows = true

        dispatcher.valid_jobs.each do |job|
          table << [job.name, to_icon(job.run), YAML.dump(job.to_hash), job.validation_message]
        end

        dispatcher.invalid_jobs.each do |job|
          table << [job.name, to_icon(job.valid?), YAML.dump(job.to_hash), job.validation_message]
        end

        puts table.render
      end

      private def to_icon(bool)
        icon = bool ? "✔".colorize(:green) : "✗".colorize(:red)
        icon.to_s
      end
    end

    class Web < Admiral::Command
      define_help description: "Run Mydumper webserver"

      define_flag config : String,
        description: "Path to config file",
        long: "config",
        short: "c",
        default: "mydumper.yml"

      def run
        Mydumper.load_config(flags.config)
        Mydumper.setup_log
        Mydumper.start_sidekiq_webserver!
      end
    end

    class Worker < Admiral::Command
      define_help description: "Run Mydumper worker"

      define_flag config : String,
        description: "Path to config file",
        long: "config",
        short: "c",
        default: "mydumper.yml"

      def run
        Mydumper.load_config(flags.config)
        Mydumper.setup_log
        Mydumper.start_sidekiq_worker!
      end
    end

    define_version Mydumper::VERSION
    define_help description: "Mydumper is an utility to dump MySQL databases"

    register_sub_command config, Config, description: "Dump Mydumper configuration"
    register_sub_command check, Check, description: "Check backup configuration"
    register_sub_command run, Runner, description: "Launch backup jobs"
    register_sub_command worker, Worker, description: "Launch backup worker"
    register_sub_command web, Web, description: "Launch backup webserver"

    def run
      puts help
    end
  end
end
