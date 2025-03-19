defmodule JazidaServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JazidaServerWeb.Telemetry,
      JazidaServer.Repo,
      {DNSCluster, query: Application.get_env(:jazida_server, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: JazidaServer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: JazidaServer.Finch},
      # Start a worker by calling: JazidaServer.Worker.start_link(arg)
      # {JazidaServer.Worker, arg},
      # Start to serve requests, typically the last entry
      JazidaServerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JazidaServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JazidaServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
