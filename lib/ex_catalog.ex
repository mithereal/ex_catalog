defmodule ExCatalog do
  @moduledoc """
  Documentation for `ExCatalog`.
  """
 repo = ExCatalog.Config.repo()

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
      from(pc in ExCatalog.Category,
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

    variations_query =
      from(v in ExCatalog.Product.Variation,
        join: p in "product",
        on: v.parent_id == p.id,
        preload: [:products]
      )

    categories_query =
      from(c in ExCatalog.Product.Category,
        join: p in "product",
        on: c.product_id == p.id,
        preload: [:categories]
      )

    metas_query =
      from(m in ExCatalog.Product.Metas,
        join: p in "product",
        on: m.product_id == p.id,
        preload: [:categories]
      )

    query =
      from(p in ExCatalog.Product,
        join: v in assoc(p, :variations),
        preload: [variations: ^variations_query],
        preload: [categories: ^categories_query],
        preload: [metas: ^metas_query],
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
