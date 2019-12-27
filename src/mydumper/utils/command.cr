module Mydumper
  module Utils
    module Command
      Log = ::Log.for(self, ::Log::Severity::Info)

      def self.dump(args : Array(String), file)
        output = File.open(file, "w")
        run_cmd(Mydumper.config.commands.mysql_dump_path, args, output)
      end

      def self.tar(args : Array(String))
        run_cmd(Mydumper.config.commands.tar_path, args)
      end

      def self.run_cmd(cmd : String, args : Array(String), stdout = nil)
        Log.debug { "Running '#{cmd}' command with args #{args.join(' ')}" }

        stdout = stdout || IO::Memory.new
        stderr = IO::Memory.new
        status = Process.run(cmd, args: args, output: stdout, error: stderr)
        if status.success?
          {status.exit_code, stdout}
        else
          {status.exit_code, stderr}
        end
      end
    end
  end
end
