defmodule ExCatalog do
  @moduledoc """
  Documentation for `ExCatalog`.
  """
  @repo ExCatalog.Config.repo()

  alias ExCatalog.Category

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
  def index(limit \\ 25, metadata \\ nil, cursor \\ nil) do
    import Ecto.Query

    query =
      from(ExCatalog.Category,
        preload: [:parent_category],
        preload: [:image]
      )

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
  def products(limit \\ 25, currency \\ :USD) do
    products(limit, nil, nil, currency)
  end

  def products(limit \\ 25, metadata, cursor, currency) do
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
  def product(sku, currency \\ nil) do
    import Ecto.Query

    query =
      from(ExCatalog.Product,
        where: [sku: ^sku],
        preload: [:variations],
        preload: [:categories],
        preload: [:metas],
        preload: [:primary_image],
        preload: [:images],
        preload: [:videos]
      )

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

      iex> ExCatalog.products_by_category("test_category", "2242", :USD)


  """
  def products_by_category(slug, limit \\ 25, currency \\ :USD) do
    products_by_category(slug, limit, nil, nil, currency)
  end

  def products_by_category(slug, limit, metadata, cursor, currency) do
    category = @repo.get_by(%Category{}, slug: slug)

    import Ecto.Query

    query =
      from(ExCatalog.Product,
        where: [category_id: ^category.id],
        preload: [:variations],
        preload: [:categories],
        preload: [:metas],
        preload: [:primary_image],
        preload: [:images],
        preload: [:videos]
      )

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
end
