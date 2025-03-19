defmodule JazidaServer.Repo.Migrations.CreateMaterials do
  use Ecto.Migration

  def change do
    create table(:materials) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
