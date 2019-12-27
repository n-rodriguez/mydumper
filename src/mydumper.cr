# Load std libs
require "file_utils"
require "ini"
require "log"
require "yaml"

# Load external libs
require "crystal-env/core"

require "admiral"
require "colorize"
require "cron_parser"
require "email"
require "mysql"
require "sidekiq"
require "sidekiq/cli"
require "sidekiq/web"
require "systemd_notify"
require "terminal_table"

# Set environment
Crystal::Env.default("development")

# Load patches
require "./kemal_patch"

# Load mydumper
require "./mydumper/**"

module Mydumper
  VERSION = "1.0.0"

  @@log_file : File? | IO::FileDescriptor?
  @@log_level : ::Log::Severity?

  SEVERITY_MAP = {
    "trace" => ::Log::Severity::Trace,
    "debug" => ::Log::Severity::Debug,
    "info"  => ::Log::Severity::Info,
    "warn"  => ::Log::Severity::Warn,
    "error" => ::Log::Severity::Error,
    "fatal" => ::Log::Severity::Fatal,
  }

  Log = ::Log.for(self)

  def self.load_config(config_path)
    config_file = File.read(config_path)
    self.config = Mydumper::Config::Global.from_yaml(config_file)
  end

  def self.config=(config : Mydumper::Config::Global)
    @@config = config
  end

  def self.config
    @@config ||= Mydumper::Config::Global.from_yaml("")
  end

  def self.load_dispatcher!
    @@dispatcher ||= Dispatcher.new(config)
  end

  def self.setup_log
    ::Log.setup do |c|
      c.bind "*", log_level, logger
    end
  end

  def self.logger
    @@logger ||= ::Log::IOBackend.new(log_file)
  end

  def self.log_file
    @@log_file ||= log_to_stdout? ? STDOUT : File.open(config.log_file, "a")
  end

  def self.log_level
    @@log_level ||= SEVERITY_MAP[config.log_level.downcase] || SEVERITY_MAP["info"]
  end

  def self.log_to_stdout?
    config.log_file.downcase == "stdout"
  end

  def self.redis_config
    {
      hostname:  config.sidekiq.redis.hostname,
      port:      config.sidekiq.redis.port,
      db:        config.sidekiq.redis.db,
      pool_size: (sidekiq_concurrency + 2),
      password:  config.sidekiq.redis.password,
    }
  end

  def self.sidekiq_concurrency
    config.sidekiq.worker.concurrency
  end

  def self.sidekiq_redis_config
    Sidekiq::RedisConfig.new(**redis_config)
  end

  def self.start_mydumper_runner!
    setup_sidekiq(sidekiq_redis_config)
  end

  def self.start_sidekiq_webserver!
    setup_sidekiq(sidekiq_redis_config)

    # Configure Kemal session
    Kemal::Session.config do |kemal_config|
      kemal_config.cookie_name = "mydumper_web"
      kemal_config.secret = config.sidekiq.webserver.secret
    end

    # Start Kemal server
    args = [] of String
    Kemal.run(args: args) do |kemal_config|
      # Set environment
      kemal_config.env = config.environment

      # Start server
      server = kemal_config.server.not_nil!
      server.bind_tcp config.sidekiq.webserver.host, config.sidekiq.webserver.port
    end

    Kemal.run(args: args)
  end

  def self.start_sidekiq_worker!
    # Create CLI
    cli = Sidekiq::CLI.new(["-e", config.environment, "-c", "#{sidekiq_concurrency}"])

    # Create worker
    worker = cli.create
    worker.redis = sidekiq_redis_config

    # Configure Sidekiq
    setup_sidekiq({pool: worker.pool, logger: worker.logger})

    # Start Sidekiq worker
    cli.run(worker)
  end

  # This initializes the Client API with a default Redis connection to localhost:6379.
  private def self.setup_sidekiq(redis_config : Sidekiq::RedisConfig)
    Sidekiq::Client.default_context = Sidekiq::Client::Context.new(redis_config)
  end

  private def self.setup_sidekiq(config)
    Sidekiq::Client.default_context = Sidekiq::Client::Context.new(**config)
  end
end

# Start the CLI
unless Crystal.env.test?
  begin
    Mydumper::CLI.run
  rescue e : Exception
    puts e.message
    exit 1
  end
end
