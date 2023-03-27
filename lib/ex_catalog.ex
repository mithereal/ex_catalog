defmodule ExCatalog do
  @moduledoc """
  Documentation for `ExCatalog`.
  """
 @repo ExCatalog.Config.repo()

  @doc """
  List version.

  ## Examples

      iex> ExCatalog.version()


  """
  @version Mix.Project.config()[:version]
  def version, do: @version

  @doc """
  List all the categories (the index).

  ## Examples

      iex> ExCatalog.index(25)


  """
  def index(limit \\ 25) do
    import Ecto.Query

    query =
      from(ExCatalog.Category,
        preload: [:parent_category],
        preload: [:image]
      )

    @repo.paginate(
      query,
      include_total_count: true,
      cursor_fields: [:inserted_at, :id],
      limit: limit
    )
  end

  @doc """
  List all products with preloads.

  ## Examples

      iex> ExCatalog.products(25)


  """
  def products(limit \\ 50) do
    import Ecto.Query


    query =
      from(ExCatalog.Product,
        preload: [:variations],
        preload: [:categories],
        preload: [:metas],
        preload: [:primary_image],
        preload: [:images],
        preload: [:videos]
      )

    @repo.paginate(
      query,
      include_total_count: true,
      cursor_fields: [:inserted_at, :id],
      limit: limit
    )
  end
end
