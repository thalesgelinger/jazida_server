defmodule JazidaServer.Loads.Load do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:client_id, :plate_id, :material_id, :signature_path, :quantity, :payment_method]

  schema "loads" do
    field :quantity, :float
    field :signature_path, :string
    field :payment_method, Ecto.Enum, values: [:installment, :cash], default: :installment

    belongs_to :client, JazidaServer.Clients.Client
    belongs_to :plate, JazidaServer.Clients.Plate
    belongs_to :material, JazidaServer.Materials.Material

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(load, attrs) do
    load
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
