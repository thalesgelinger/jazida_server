defmodule JazidaServer.Repo.Migrations.CreatePlates do
  use Ecto.Migration

  def change do
    create table(:plates) do
      add :name, :string
      add :client_id, references(:clients, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:plates, [:client_id])
  end
end
