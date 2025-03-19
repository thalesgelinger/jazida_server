defmodule JazidaServer.Clients.Plate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plates" do
    field :name, :string

    belongs_to :client, JazidaServer.Clients.Client

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(plate, attrs) do
    plate
    |> cast(attrs, [:name, :client_id])
    |> validate_required([:name, :client_id])
  end
end
