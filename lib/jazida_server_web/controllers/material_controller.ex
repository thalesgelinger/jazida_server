defmodule JazidaServerWeb.MaterialController do
  use JazidaServerWeb, :controller

  alias JazidaServer.Materials
  alias JazidaServer.Materials.Material

  action_fallback JazidaServerWeb.FallbackController

  def index(conn, _params) do
    materials = Materials.list_materials()
    render(conn, :index, materials: materials)
  end

  def create(conn, %{"material" => material_params}) do
    with {:ok, %Material{} = material} <- Materials.create_material(material_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/materials/#{material}")
      |> render(:show, material: material)
    end
  end

  def show(conn, %{"id" => id}) do
    material = Materials.get_material!(id)
    render(conn, :show, material: material)
  end

  def update(conn, %{"id" => id, "material" => material_params}) do
    material = Materials.get_material!(id)

    with {:ok, %Material{} = material} <- Materials.update_material(material, material_params) do
      render(conn, :show, material: material)
    end
  end

  def delete(conn, %{"id" => id}) do
    material = Materials.get_material!(id)

    with {:ok, %Material{}} <- Materials.delete_material(material) do
      send_resp(conn, :no_content, "")
    end
  end
end
