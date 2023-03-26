defmodule ExCatalog.Repo.Migrations.AddProductCategoriesTable do
  use Ecto.Migration

  def change do
    add :category_id, references(:categories, on_delete: :nothing)
    add :product_id, references(:products, on_delete: :nothing)
  end
end
