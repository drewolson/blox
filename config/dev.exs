use Mix.Config

config :blox, Blox.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  cache_static_lookup: false,
  code_reloading: true,
  watchers: [
    {Path.expand("node_modules/brunch/bin/brunch"), ["watch"]}
  ],
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :blox, Blox.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "blox_dev",
  username: System.get_env("USER")
