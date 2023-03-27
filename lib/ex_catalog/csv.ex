defmodule ExCatalog.Csv do
  @moduledoc """
  csv functions.
  """
  require Logger

  @doc """
  Export products to file

  ## Examples

      iex> ExCatalog.export_products()


  """
  def export_products(filename \\ "products.csv", limit \\ 500) do
    case ExCatalog.Util.module_compiled?(CSV) do
      true ->
        {data, meta} = ExCatalog.products(limit)

        Enum.each(data, fn p ->
          data = CSV.encode(p)
          File.write(filename, data)
        end)

        total_products = meta.total_count - limit
        pages_left = total_products / limit

        Enum.reduce(pages_left, meta, fn _x ->
          {data, meta} = ExCatalog.products(limit, meta, :after)

          Enum.each(data, fn p ->
            data = CSV.encode(p)
            File.write(filename, data)
          end)

          meta
        end)

      false ->
        Logger.error("CSV Module Not Installed")
        {:error, "CSV Module Not Installed"}
    end
  end

  @doc """
  Export categories to file

  ## Examples

      iex> ExCatalog.export_categories()


  """
  def export_categories(filename \\ "categories.csv", limit \\ 500) do
    case ExCatalog.Util.module_compiled?(CSV) do
      true ->
        {data, meta} = ExCatalog.index(limit)

        Enum.each(data, fn p ->
          data = CSV.encode(p)
          File.write(filename, data)
        end)

        total_categories = meta.total_count - limit
        pages_left = total_categories / limit

        Enum.reduce(pages_left, meta, fn _x ->
          {data, meta} = ExCatalog.index(limit, meta, :after)

          Enum.each(data, fn p ->
            data = CSV.encode(p)
            File.write(filename, data)
          end)

          meta
        end)

      false ->
        Logger.error("CSV Module Not Installed")
        {:error, "CSV Module Not Installed"}
    end
  end

  @doc """
  Export all to files

  ## Examples

      iex> ExCatalog.export()

  """

  def export() do
    {category_status, _} = export_categories()
    {products_status, _} = export_products()

    case category_status == :ok && products_status == :ok do
      true -> {:ok, "Export Success"}
      false -> {:error, "Export Failure"}
    end
  end
end
