defmodule ExCatalog.Repo.Migrations.AddVariationsTable do
  use Ecto.Migration

  def change do
    create table(:catalog_variations) do
    add :parent_id, references(:catalog_products, on_delete: :nothing)
    add :product_id, references(:catalog_products, on_delete: :nothing)
  end
  end
end
