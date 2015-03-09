use Mix.Config

config :blox, Blox.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  cache_static_lookup: false,
  watchers: [
    {Path.expand("node_modules/brunch/bin/brunch"), ["watch"]}
  ],
  live_reload: [
    Path.expand("priv/static/js/app.js"),
    Path.expand("priv/static/css/app.css"),
    Path.expand("web/templates/**/*.eex")
  ]

config :phoenix, :code_reloader, true

config :logger, :console, format: "[$level] $message\n"

config :blox, Blox.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "blox_dev",
  username: System.get_env("USER")
