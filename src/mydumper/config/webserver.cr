module Mydumper
  module Config
    class Webserver < Base
      property host : String = "localhost"
      property port : Int32 = 3000
      property secret : String = UUID.random.to_s
    end
  end
end
