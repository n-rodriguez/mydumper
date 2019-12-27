module Mydumper
  module Config
    class Global < Base
      property environment : String = "production"
      property log_file : String = "./log/mydumper.log"
      property log_level : String = "info"
      property backup_dir : String = "/var/backups"
      property skip_databases : Array(String) = [] of String
      property commands : Mydumper::Config::Commands = Mydumper::Config::Commands.from_yaml("")
      property sidekiq : Mydumper::Config::Sidekiq = Mydumper::Config::Sidekiq.from_yaml("")
      property email : Mydumper::Config::Email = Mydumper::Config::Email.from_yaml("")
      property jobs : Array(Mydumper::Config::Job) = Array(Mydumper::Config::Job).new
    end
  end
end
