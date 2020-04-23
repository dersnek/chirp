defmodule Chirp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Chirp.Repo,
      # Start the Telemetry supervisor
      ChirpWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Chirp.PubSub},
      # Start the Endpoint (http/https)
      ChirpWeb.Endpoint
      # Start a worker by calling: Chirp.Worker.start_link(arg)
      # {Chirp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chirp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ChirpWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
