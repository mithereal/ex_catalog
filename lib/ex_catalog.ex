defmodule ExCatalog do
  @moduledoc """
  Documentation for `ExCatalog`.
  """

  @doc """
  List version.

  ## Examples

      iex> ExCatalog.version()


  """
  @version Mix.Project.config()[:version]
  def version, do: @version

  @doc """
  List all products with preloads.

  ## Examples

      iex> ExCatalog.list_products(25)


  """
  def list_products(limit \\ 50) do
    import Ecto.Query

    variations_query = from v in ExCatalog.Product.Variation,
                        join: p in "product", on: v.parent_id == p.id,
                        preload: [:products],
                        order_by: [asc: p.inserted_at]

    categories_query = from c in ExCatalog.Product.Category,
                        join: p in "product", on: c.product_id == p.id,
                        preload: [:categories],
                        order_by: [asc: p.inserted_at]

    query = from p in ExCatalog.Product,
             join: v in assoc(p, :variations),
             preload: [variations: ^variations_query],
             preload: [categories: ^categories_query],
             preload: [:images],
             preload: [:metas],
             preload: [:videos]

    Repo.paginate(
      query,
      include_total_count: true,
      cursor_fields: [:inserted_at, :id],
      limit: limit
    )
  end
end
