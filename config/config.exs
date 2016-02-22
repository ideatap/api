# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :ideatap, Ideatap.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "W2CWm0tNrw2ttkH8gDROHV24AlonM4Yi73Fzxy9CXyrc+gJGjKlyctiMFQb2TpeU",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: Ideatap.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    twitter: {Ueberauth.Strategy.Twitter, []}
  ]

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: "hypY26Za6oV2oDIGQqWSjfzy3",
  consumer_secret: "QWs8EAnA8svS8FFxfJ8GDcEq50BHe7sC0aQDAe2uvPXz45MKPm"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
