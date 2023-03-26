defmodule ExCatalog.Repo.Migrations.AddVariationsTable do
  use Ecto.Migration

  def change do
    add :parent_id, references(:products, on_delete: :nothing)
    add :product_id, references(:products, on_delete: :nothing)
  end
end
