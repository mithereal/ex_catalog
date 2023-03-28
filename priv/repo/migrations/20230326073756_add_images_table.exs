defmodule ExCatalog.Repo.Migrations.AddImagesTable do
  use Ecto.Migration

  def change do
    key_type = Application.get_env(:ex_catalog, :key_type, :integer)

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
