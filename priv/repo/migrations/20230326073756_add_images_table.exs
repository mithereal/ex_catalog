defmodule ExCatalog.Repo.Migrations.AddImagesTable do
  use Ecto.Migration

  def change do
    key_type = ExCatalog.Config.key_type(:migration)

    create table(:catalog_images, primary_key: false) do
      add(:id, key_type, primary_key: true)
      add(:title, :string)
      add(:description, :string)
      add(:path, :string)
      add(:height, :string)
      add(:width, :string)
    end
  end
end
