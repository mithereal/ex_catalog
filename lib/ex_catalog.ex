defmodule ExCatalog do
  @moduledoc """
  Documentation for `ExCatalog`.
  """
  @repo ExCatalog.Config.repo()

  alias ExCatalog.Category
  alias ExCatalog.Product

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
  def index(limit \\ 25, metadata \\ nil, cursor \\ nil, deleted \\ false) do
    import Ecto.Query
    import Ecto.SoftDelete.Query

    query =
      case(deleted) do
        false ->
          from(ExCatalog.Category,
            preload: [:parent_category],
            preload: [:image]
          )

        true ->
          from(ExCatalog.Category,
            preload: [:parent_category],
            preload: [:image]
          )
          |> with_undeleted
      end

    case cursor do
      :before ->
        @repo.paginate(
          query,
          before: metadata.before,
          include_total_count: true,
          cursor_fields: [:inserted_at, :id],
          limit: limit
        )

      :after ->
        @repo.paginate(
          query,
          after: metadata.after,
          include_total_count: true,
          cursor_fields: [:inserted_at, :id],
          limit: limit
        )

      _ ->
        @repo.paginate(
          query,
          include_total_count: true,
          cursor_fields: [:inserted_at, :id],
          limit: limit
        )
    end
  end

  @doc """
  List all products with preloads and optional currency conversion..

  ## Examples

      iex> ExCatalog.products(25)
      iex> ExCatalog.products(25,:USD)


  """
  def products(limit \\ 25, currency \\ :USD, deleted \\ false) do
    products(limit, nil, nil, currency, deleted)
  end

  def products(limit \\ 25, metadata, cursor, currency, deleted) do
    import Ecto.Query
    import Ecto.SoftDelete.Query

    query =
      case(deleted) do
        false ->
          from(ExCatalog.Product,
            preload: [:variations],
            preload: [:categories],
            preload: [:metas],
            preload: [:primary_image],
            preload: [:images],
            preload: [:videos]
          )

        true ->
          from(ExCatalog.Product,
            preload: [:variations],
            preload: [:categories],
            preload: [:metas],
            preload: [:primary_image],
            preload: [:images],
            preload: [:videos]
          )
          |> with_undeleted
      end

    reply =
      case cursor do
        :before ->
          @repo.paginate(
            query,
            before: metadata.before,
            include_total_count: true,
            cursor_fields: [:inserted_at, :id],
            limit: limit
          )

        :after ->
          @repo.paginate(
            query,
            after: metadata.after,
            include_total_count: true,
            cursor_fields: [:inserted_at, :id],
            limit: limit
          )

        _ ->
          @repo.paginate(
            query,
            include_total_count: true,
            cursor_fields: [:inserted_at, :id],
            limit: limit
          )
      end

    case currency do
      nil ->
        reply

      _ ->
        {p, metadata} = reply

        modified =
          Enum.map(p, fn x ->
            {:ok, price} = ExCatalog.Currencies.convert(x.price, currency)
            %{x | price: price}
          end)

        {modified, metadata}
    end
  end

  @doc """
  List product with preloads by sku and optional currency conversion.

  ## Examples

      iex> ExCatalog.product("2242", :USD)


  """
  def product(sku, currency \\ nil, deleted \\ false) do
    import Ecto.Query
    import Ecto.SoftDelete.Query

    query =
      case(deleted) do
        false ->
          from(ExCatalog.Product,
            where: [sku: ^sku],
            preload: [:variations],
            preload: [:categories],
            preload: [:metas],
            preload: [:primary_image],
            preload: [:images],
            preload: [:videos]
          )

        true ->
          from(ExCatalog.Product,
            where: [sku: ^sku],
            preload: [:variations],
            preload: [:categories],
            preload: [:metas],
            preload: [:primary_image],
            preload: [:images],
            preload: [:videos]
          )
          |> with_undeleted
      end

    [reply] = @repo.all(query)

    case currency do
      nil ->
        reply

      _ ->
        {:ok, price} = ExCatalog.Currencies.convert(reply.price, currency)
        %{reply | price: price}
    end
  end

  @doc """
  List product with preloads by category and optional currency conversion.

  ## Examples

      iex> ExCatalog.products_by_category("test_category", "2242", :USD, false, order_by: :sku)


  """
  def products_by_category(slug, limit \\ 25, currency \\ :USD, deleted \\ false, opts \\ []) do
    products_by_category(slug, limit, nil, nil, currency, deleted, opts)
  end

  def products_by_category(slug, limit, metadata, cursor, currency, deleted, opts) do
    category = @repo.get_by(%Category{}, slug: slug)

    import Ecto.Query
    import Ecto.SoftDelete.Query

    order = Keyword.get(opts, :order) || :desc
    by = Keyword.get(opts, :order_by) || :updated_at
    order_by = [{order, by}]

    query =
      case(deleted) do
        false ->
          from(ExCatalog.Product,
            where: [category_id: ^category.id],
            order_by: ^order_by,
            preload: [:variations],
            preload: [:categories],
            preload: [:metas],
            preload: [:primary_image],
            preload: [:images],
            preload: [:videos]
          )

        true ->
          from(ExCatalog.Product,
            where: [category_id: ^category.id],
            preload: [:variations],
            preload: [:categories],
            preload: [:metas],
            preload: [:primary_image],
            preload: [:images],
            preload: [:videos]
          )
          |> with_undeleted
      end

    reply =
      case cursor do
        :before ->
          @repo.paginate(
            query,
            before: metadata.before,
            include_total_count: true,
            cursor_fields: [:inserted_at, :id],
            limit: limit
          )

        :after ->
          @repo.paginate(
            query,
            after: metadata.after,
            include_total_count: true,
            cursor_fields: [:inserted_at, :id],
            limit: limit
          )

        _ ->
          @repo.paginate(
            query,
            include_total_count: true,
            cursor_fields: [:inserted_at, :id],
            limit: limit
          )
      end

    case currency do
      nil ->
        reply

      _ ->
        {data, meta} = reply

        modified =
          Enum.map(data, fn x ->
            {:ok, price} = ExCatalog.Currencies.convert(x.price, currency)
            %{x | price: price}
          end)

        {modified, meta}
    end
  end

  @doc """
  Change the status active or disabled, this controls which products the user can see, (by default only the active products are displayed)

  ## Examples

      iex> id = "1111-2222-3333-4444"
      iex> ExCatalog.active(:category, id)
      iex> ExCatalog.active(:product, id)


  """
  def active(type, id) do
    import Ecto.Query
    import Ecto.SoftDelete.Query

    query =
      case type do
        :category ->
          from(c in Category, where: c.id == ^id, select: c)
          |> with_undeleted

        _ ->
          from(p in Product, where: p.id == ^id, select: p)
          |> with_undeleted
      end

    case Keyword.has_key?(@repo.__info__(:functions), :soft_restore!) do
      true ->
        @repo.one!(query)
        |> @repo.soft_restore!()

      false ->
        {:error, "Not Available"}
    end
  end

  def active(type, id, false) do
    import Ecto.Query
    import Ecto.SoftDelete.Query

    case type do
      :category ->
        @repo.get_by!(Category, id: id)

        from(c in Category, where: c.id == ^id, select: c)
        |> @repo.soft_delete!()

      _ ->
        from(p in Product, where: p.id == ^id, select: p)
        |> @repo.soft_delete!()
    end
  end
end
