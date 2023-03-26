defmodule ExCatalog.Config do
  @doc """
  Return value by key from config.exs file.
  """

  alias ExCatalog.InvalidConfigError

  def get(name, default \\ nil) do
    Application.get_env(:ex_catalog, name, default)
  end

  def repo, do: List.first(Application.fetch_env!(:ex_catalog, :ecto_repos))
  def repos, do: Application.fetch_env!(:ex_catalog, :ecto_repos)

  @spec config() :: Keyword.t() | none()
  def config() do
    case Application.get_env(:ex_catalog, :ecto_repos, :not_found) do
      :not_found ->
        raise InvalidConfigError, "ex_catalog config not found"

      config ->
        if not Keyword.keyword?(config) do
          raise InvalidConfigError,
                "ex_catalog config was found, but doesn't contain a keyword list."
        end

        config
    end
  end
end
