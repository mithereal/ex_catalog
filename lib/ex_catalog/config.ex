defmodule ExCatalog.Config do
  @doc """
  Return value by key from config.exs file.
  """


  def get(name, default \\ nil) do
    Application.get_env(:ex_checkout, name, default)
  end

  def repo, do: List.first(Application.fetch_env!(:ex_catalog, :ecto_repos))

  @spec config() :: Keyword.t() | none()
  def config() do
  end
end
