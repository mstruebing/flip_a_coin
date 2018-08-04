# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :flip_a_coin,
  ecto_repos: [FlipACoin.Repo]

# Configures the endpoint
config :flip_a_coin, FlipACoinWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a2K/aBJSIBHHSBBSimPeI3xdw5EK2BIxRTanh0y16kKOpRc2iD/zMx5QDyy7hcg+",
  render_errors: [view: FlipACoinWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FlipACoin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
