module Mydumper
  module Config
    class Redis < Base
      property hostname : String = "localhost"
      property port : Int32 = 6379
      property db : Int32 = 0
      property pool_size : Int32 = 4
      property password : String?
    end
  end
end
