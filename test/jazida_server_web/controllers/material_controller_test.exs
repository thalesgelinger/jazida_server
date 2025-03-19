defmodule JazidaServerWeb.MaterialControllerTest do
  use JazidaServerWeb.ConnCase

  import JazidaServer.MaterialsFixtures

  alias JazidaServer.Materials.Material

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all materials", %{conn: conn} do
      conn = get(conn, ~p"/api/materials")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create material" do
    test "renders material when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/materials", material: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/materials/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/materials", material: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update material" do
    setup [:create_material]

    test "renders material when data is valid", %{conn: conn, material: %Material{id: id} = material} do
      conn = put(conn, ~p"/api/materials/#{material}", material: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/materials/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, material: material} do
      conn = put(conn, ~p"/api/materials/#{material}", material: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete material" do
    setup [:create_material]

    test "deletes chosen material", %{conn: conn, material: material} do
      conn = delete(conn, ~p"/api/materials/#{material}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/materials/#{material}")
      end
    end
  end

  defp create_material(_) do
    material = material_fixture()
    %{material: material}
  end
end
