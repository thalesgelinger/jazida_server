defmodule JazidaServer.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
