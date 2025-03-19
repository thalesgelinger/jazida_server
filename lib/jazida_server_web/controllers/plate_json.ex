defmodule JazidaServerWeb.PlateJSON do
  alias JazidaServer.Clients.Plate

  @doc """
  Renders a list of plates.
  """
  def index(%{plates: plates}) do
    %{data: for(plate <- plates, do: data(plate))}
  end

  @doc """
  Renders a single plate.
  """
  def show(%{plate: plate}) do
    %{data: data(plate)}
  end

  defp data(%Plate{} = plate) do
    %{
      id: plate.id,
      name: plate.name,
      client_id: plate.client.id
    }
  end
end
