defmodule PhoenixReact.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixReactWeb.Telemetry,
      PhoenixReact.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_react, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixReact.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixReact.Finch},
      # Start a worker by calling: PhoenixReact.Worker.start_link(arg)
      # {PhoenixReact.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixReactWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixReact.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixReactWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
