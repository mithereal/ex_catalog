defmodule ExCatalog.Template.Example do
  @moduledoc false

  @behaviour ExCatalog.Pdf.Template

  def render(%{bar: "bar"} = args) do
    EEx.eval_string(html(), args)
  end

  def html() do
    "<title>foo <%= bar %></title>"
  end
end
