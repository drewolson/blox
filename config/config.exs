use Mix.Config

config :blox, Blox.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "thisisatestvaluthisisatestvaluthisisatestvalueeethisisatestvalue",
  debug_errors: false,
  root: Path.expand("..", __DIR__),
  pubsub: [
    name: Blox.PubSub,
    adapter: Phoenix.PubSub.PG2
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
