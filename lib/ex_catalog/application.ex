defmodule ExCatalog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias ExCatalog.Config

  @impl true
  def start(_type, args) do
    repo = Config.repo()

    children =
      [
        {repo, args}
        # Starts a worker by calling: ExCatalog.Worker.start_link(arg)
        # {ExCatalog.Worker, arg}
      ]
      |> maybe_autoload_exchange_rates()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExCatalog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @version Mix.Project.config()[:version]
  def version, do: @version

  @doc """
  Add a currency to the application and load into ets
  """
  def add_currency(params) do
    ExCatalog.Currencies.new(params)
  end

  defp maybe_autoload_exchange_rates(children) do
    autoload = Application.get_env(:ex_catalog, :autoload_exchange_rates, false)

    data =
      if(autoload == true) do
        [
          {Cldr.Currency, [callback: {ExCatalog.Currencies, :init, []}]},
          {ExCatalog.Currency.Reload, name: ExCatalog.Currency.Reload}
        ]
      else
        []
      end

    children ++ data
  end
end
