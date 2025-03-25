defmodule JazidaServer.Repo.Migrations.AddLoadPaymentMethod do
  use Ecto.Migration

  def change do
    alter table(:loads) do
      add :payment_method, :string
    end
  end
end
