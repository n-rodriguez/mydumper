module Mydumper
  module Config
    class Base
      include YAML::Serializable

      def to_hash
        Hash(String, String | Array(String)).from_yaml(YAML.dump(self))
      end
    end
  end
end
