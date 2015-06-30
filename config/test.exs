use Mix.Config

config :blox, Blox.Endpoint,
  http: [port: 4001]

config :logger, level: :warn

config :blox, Blox.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "blox_test",
  username: System.get_env("PG_USER") || System.get_env("USER"),
  size: 1,
  max_overflow: 0
