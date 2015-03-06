use Mix.Config

# Configures the endpoint
config :blox, Blox.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "thisisatestvalue",
  debug_errors: false,
  pubsub: [name: Blox.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
