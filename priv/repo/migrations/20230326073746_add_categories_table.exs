defmodule ExCatalog.Repo.Migrations.AddCategoriesTable do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add(:title, :string)
      add(:description, :string)
      add(:sort_order, :integer)
    end
  end
end