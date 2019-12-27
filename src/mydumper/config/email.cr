module Mydumper
  module Config
    class Email < Base
      property to : String = "root@localhost"
      property from : String = "mydumper@localhost"
      property smtp_host : String = "localhost"
      property smtp_port : Int32 = 25
    end
  end
end
