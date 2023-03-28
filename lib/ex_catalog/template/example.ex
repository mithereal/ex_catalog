defmodule ExCatalog.Template.Example do
  @moduledoc """
  An Example of a Html Template to be sent to the PDF Creator
  """

  @behaviour ExCatalog.Pdf.Template

  @impl true
  def render(%{product: product, sku: sku} = args) do
    EEx.eval_string(html(), args)
  end

  def html() do
    "<div><span><%= product.title %></span><span><%= product.sku %></span></div>"
  end
end
