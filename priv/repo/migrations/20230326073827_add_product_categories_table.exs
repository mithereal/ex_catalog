defmodule ExCatalog.Repo.Migrations.AddProductCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:catalog_product_categories) do
    add :category_id, references(:catalog_categories, on_delete: :nothing)
    add :product_id, references(:catalog_products, on_delete: :nothing)
  end
  end
end
