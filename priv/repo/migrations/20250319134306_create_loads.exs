defmodule JazidaServer.Repo.Migrations.CreateLoads do
  use Ecto.Migration

  def change do
    create table(:loads) do
      add :quantity, :float
      add :signature_path, :string
      add :client_id, references(:clients, on_delete: :nothing)
      add :plate_id, references(:plates, on_delete: :nothing)
      add :material_id, references(:materials, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:loads, [:client_id])
    create index(:loads, [:plate_id])
    create index(:loads, [:material_id])
  end
end
