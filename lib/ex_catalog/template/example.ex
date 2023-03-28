defmodule ExCatalog.Template.Example do
  @moduledoc false

  @behaviour ExCatalog.Pdf.Template

  @impl true
  def render(%{product: product, sku: sku} = args) do
    EEx.eval_string(html(), args)
  end

  def html() do
    "<div><span><%= product.title %></span><span><%= product.sku %></span></div>"
  end
end
