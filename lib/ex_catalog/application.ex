defmodule ExCatalog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, args) do
    [repo] = Application.get_env(:ex_catalog, :ecto_repos)

    children = [
      {repo, args}
      # Starts a worker by calling: ExCatalog.Worker.start_link(arg)
      # {ExCatalog.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExCatalog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @version Mix.Project.config()[:version]
  def version, do: @version
end
