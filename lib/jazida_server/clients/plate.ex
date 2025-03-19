defmodule JazidaServer.Clients.Plate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plates" do
    field :name, :string
    field :client_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(plate, attrs) do
    plate
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
