defmodule ExCatalog.Currency.Reload do
  use Task
  require Logger

  @moduledoc false

  def start_link(_data \\ []) do
    Logger.info("Currencies will be reloaded every 300 seconds.")
    Task.start_link(&poll/0)
  end

  defp poll() do
    receive do
    after
      300_000 ->
        ExCatalog.Currencies.reload()
        poll()
    end
  end
end
