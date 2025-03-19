defmodule JazidaServerWeb.MaterialJSON do
  alias JazidaServer.Materials.Material

  @doc """
  Renders a list of materials.
  """
  def index(%{materials: materials}) do
    %{data: for(material <- materials, do: data(material))}
  end

  @doc """
  Renders a single material.
  """
  def show(%{material: material}) do
    %{data: data(material)}
  end

  defp data(%Material{} = material) do
    %{
      id: material.id,
      name: material.name
    }
  end
end
