defmodule ExCatalog.Pdf do
  @moduledoc """
  pdf functions.
  """
  require Logger

  @doc """
  Export products to file

  ## Examples

      iex> ExCatalog.export_products(ExCatalog.Template.Example)


  """
  def export_products(
        template,
        limit \\ 500,
        filename \\ "products.pdf",
        currency \\ :USD,
        deleted \\ false
      ) do
    case ExCatalog.Util.module_compiled?(ChromicPDF) do
      true ->
        {data, meta} = ExCatalog.products(limit, currency, deleted)

        html =
          Enum.map(data, fn p ->
            rendered = template.render(p)
            {:html, rendered}
          end)

        page = 1

        [h | _] = String.split(filename, ".")
        pdf_filename = "#{h}-1-#{limit}.pdf"
        ChromicPDF.print_to_pdf(html, output: pdf_filename)

        total_products = meta.total_count - limit
        pages_left = (total_products / limit) |> trunc()

        Enum.reduce(pages_left, {meta, page}, fn _x ->
          {data, meta} = ExCatalog.products(limit, meta, :after)

          rendered =
            Enum.map(data, fn p ->
              template.render(p)
            end)
            |> Enum.join(" ")

          html = {:html, rendered}

          [h | _] = String.split(filename, ".")
          pdf_filename = "#{h}-#{page}-#{limit}.pdf"
          ChromicPDF.print_to_pdf(html, output: pdf_filename)

          {meta, page + 1}
        end)

      false ->
        Logger.error("ChromicPDF Module Not Installed")
        {:error, "ChromicPDF Module Not Installed"}
    end
  end

  @doc """
  Export categories to file

  ## Examples

      iex> ExCatalog.export_categories(ExCatalog.Template.Category)


  """
  def export_categories(template, limit \\ 500, filename \\ "categories.csv", deleted \\ false) do
    case ExCatalog.Util.module_compiled?(CSV) do
      true ->
        {data, meta} = ExCatalog.index(limit, nil, nil, deleted)

        rendered =
          Enum.map(data, fn p ->
            template.render(p)
          end)
          |> Enum.join(" ")

        html = {:html, rendered}

        page = 1

        [h | _] = String.split(filename, ".")
        pdf_filename = "#{h}-1-#{limit}.pdf"
        ChromicPDF.print_to_pdf(html, output: pdf_filename)

        total_categories = meta.total_count - limit
        pages_left = (total_categories / limit) |> trunc()

        Enum.reduce(pages_left, {meta, page}, fn _x ->
          {data, meta} = ExCatalog.index(limit, meta, :after)

          html =
            Enum.map(data, fn p ->
              rendered = template.render(p)
              {:html, rendered}
            end)

          [h | _] = String.split(filename, ".")
          pdf_filename = "#{h}-#{page}-#{limit}.pdf"
          ChromicPDF.print_to_pdf(html, output: pdf_filename)

          {meta, page + 1}
        end)

      false ->
        Logger.error("ChromicPDF Module Not Installed")
        {:error, "ChromicPDF Module Not Installed"}
    end
  end

  @doc """
  Export all to files

  ## Examples

      iex> categories_template = ExCatalog.Pdf.Template.Category
      iex> products_template = ExCatalog.Pdf.Template.Product
      iex> ExCatalog.export({categories_template,products_template})

  """

  def export(
        {categories_template, products_template},
        limit \\ 500,
        currency \\ :USD,
        deleted \\ false
      ) do
    {category_status, _} = export_categories(categories_template, limit)
    {products_status, _} = export_products(products_template, limit, currency, deleted)

    case category_status == :ok && products_status == :ok do
      true -> {:ok, "Export Success"}
      false -> {:error, "Export Failure"}
    end
  end
end

defmodule ExCatalog.Pdf.Template do
  @callback render(args :: term) ::
              {:ok, result :: term}
              | {:error, reason :: term}
end
