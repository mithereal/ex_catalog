defmodule ExCatalog.Repo.Migrations.AddMetasTable do
  use Ecto.Migration

  def change do
    create table(:metas) do
      add(:key, :string)
      add(:data, :string)
    end
  end
end
