module Mydumper
  module Config
    class Commands < Base
      property mysql_client_path : String = "/usr/bin/mysql"
      property mysql_dump_path : String = "/usr/bin/mysqldump"
      property tar_path : String = "/usr/bin/tar"
    end
  end
end
