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
end
