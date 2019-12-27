module Mydumper
  module Config
    class Worker < Base
      property concurrency : Int32 = 2
    end
  end
end
