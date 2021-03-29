defmodule EmployeeStatus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      EmployeeStatus.Repo,
      # Start the Telemetry supervisor
      EmployeeStatusWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: EmployeeStatus.PubSub},
      # Start the Endpoint (http/https)
      EmployeeStatusWeb.Endpoint,
      {Absinthe.Subscription, EmployeeStatusWeb.Endpoint}
      # Start a worker by calling: EmployeeStatus.Worker.start_link(arg)
      # {EmployeeStatus.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EmployeeStatus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    EmployeeStatusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
