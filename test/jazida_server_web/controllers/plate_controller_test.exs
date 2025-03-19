defmodule JazidaServerWeb.PlateControllerTest do
  use JazidaServerWeb.ConnCase

  import JazidaServer.ClientsFixtures

  alias JazidaServer.Clients.Plate

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
    test "lists all plates", %{conn: conn} do
      conn = get(conn, ~p"/api/plates")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create plate" do
    test "renders plate when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/plates", plate: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/plates/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/plates", plate: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update plate" do
    setup [:create_plate]

    test "renders plate when data is valid", %{conn: conn, plate: %Plate{id: id} = plate} do
      conn = put(conn, ~p"/api/plates/#{plate}", plate: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/plates/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, plate: plate} do
      conn = put(conn, ~p"/api/plates/#{plate}", plate: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete plate" do
    setup [:create_plate]

    test "deletes chosen plate", %{conn: conn, plate: plate} do
      conn = delete(conn, ~p"/api/plates/#{plate}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/plates/#{plate}")
      end
    end
  end

  defp create_plate(_) do
    plate = plate_fixture()
    %{plate: plate}
  end
end
