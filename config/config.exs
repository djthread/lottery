# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lottery,
  ecto_repos: [Lottery.Repo]

# Configures the endpoint
config :lottery, Lottery.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xHzojwj/w7wm4BB4tGtzm4Bz60lGpGql70/Co55l4ZoeEbj4TuMyqvc1iHPwRXi+",
  render_errors: [view: Lottery.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Lottery.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
