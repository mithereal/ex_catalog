defmodule ExCatalog.Schema do
  defmacro __using__(type) do
    case type do
      :binary_id ->
        quote do
          use Ecto.Schema
          @primary_key {:id, :binary_id, autogenerate: true}
          @foreign_key_type :binary_id
        end

      _ ->
        quote do
          use Ecto.Schema
        end
    end
  end
end
