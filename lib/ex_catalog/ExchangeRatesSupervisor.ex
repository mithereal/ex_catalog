defmodule ExCatalog.ExchangeRates.Supervisor do
  @moduledoc false
  use DynamicSupervisor

  def child_spec(args) do
    %{
      id: __MODULE__,
      start: {Money.ExchangeRates.Supervisor, :start_link, [args]},
      type: :supervisor
    }
  end

  def init(args) do
    try do
      DynamicSupervisor.init(
        strategy: :one_for_one,
        extra_arguments: args
      )
    rescue
      _ -> throw("Exchange Rates Updater Failed To Start")
    end
  end
end
