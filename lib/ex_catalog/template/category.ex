defmodule ExCatalog.Template.Category do
  @moduledoc """
  An Example of a Html Template to be sent to the PDF Creator
  """

  @behaviour ExCatalog.Pdf.Template

  @impl true
  def render(%{categories: _categories} = args) do
    EEx.eval_string(html(), args) |> slot()
  end

  defp html() do
    "<div><span><%= categories.title %></span></div>"
  end

  defp slot(inner) do
    "<div><span>#{inner}</span></div>"
  end
end
