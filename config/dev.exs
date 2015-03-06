use Mix.Config

config :blox, Blox.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  cache_static_lookup: false

config :phoenix, :code_reloader, true

config :logger, :console, format: "[$level] $message\n"

config :blox, Blox.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "blox_dev",
  username: System.get_env("USER")
