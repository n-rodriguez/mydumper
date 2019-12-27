module Mydumper
  module Config
    class Sidekiq < Base
      property redis : Mydumper::Config::Redis = Mydumper::Config::Redis.from_yaml("")
      property webserver : Mydumper::Config::Webserver = Mydumper::Config::Webserver.from_yaml("")
      property worker : Mydumper::Config::Worker = Mydumper::Config::Worker.from_yaml("")
    end
  end
end
