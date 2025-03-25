defmodule JazidaServerWeb.LoadJSON do
  alias JazidaServer.Loads.Load

  @doc """
  Renders a list of loads.
  """
  def index(%{loads: loads}) do
    %{data: for(load <- loads, do: data(load))}
  end

  @doc """
  Renders a single load.
  """
  def show(%{load: load}) do
    %{data: data(load)}
  end

  defp data(%Load{} = load) do
    %{
      id: load.id,
      quantity: load.quantity,
      signature_path: load.signature_path,
      inserted_at: load.inserted_at,
      payment_method: load.payment_method,
      client: load.client.name,
      plate: load.plate.name,
      material: load.material.name
    }
  end
end
