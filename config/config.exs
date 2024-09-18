# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :phoenix_react,
  ecto_repos: [PhoenixReact.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :phoenix_react, PhoenixReactWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: PhoenixReactWeb.ErrorHTML, json: PhoenixReactWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: PhoenixReact.PubSub,
  live_view: [signing_salt: "2kgEbiaT"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :phoenix_react, PhoenixReact.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :phoenix_react, PhoenixReactWeb.Auth.Guardian,
  issuer: "Reynald Gragasin",
  secret_key: "caBiR6Zx5HOPT3+3ZkBm8CuOMskFYBmCet8N+W3uacIRD4asndXsM4mS+sM5WO7Q"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :esbuild,
  version: "0.17.11",
  phoenix_react: [
    args:
      ~w(js/app.jsx --bundle --target=es2022 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]


# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# config :guardian, Guardian.DB,
#   repo: PhoenixReact.Repo,
#   schema_name: "guardian_tokens",
#   sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
