defmodule ExCatalog.Repo.Migrations.AddImagesTable do
  use Ecto.Migration

    def change do
      create table(:catalog_images) do
        add(:title, :string)
        add(:description, :string)
        add(:path, :string)
        add(:height, :string)
        add(:width, :string)
      end
    end
  end
