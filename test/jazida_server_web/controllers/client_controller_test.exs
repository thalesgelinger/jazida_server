defmodule JazidaServerWeb.ClientControllerTest do
  use JazidaServerWeb.ConnCase

  import JazidaServer.ClientsFixtures

  alias JazidaServer.Clients.Client

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
    test "lists all clients", %{conn: conn} do
      conn = get(conn, ~p"/api/clients")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create client" do
    test "renders client when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/clients", client: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/clients/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/clients", client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update client" do
    setup [:create_client]

    test "renders client when data is valid", %{conn: conn, client: %Client{id: id} = client} do
      conn = put(conn, ~p"/api/clients/#{client}", client: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/clients/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, client: client} do
      conn = put(conn, ~p"/api/clients/#{client}", client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete client" do
    setup [:create_client]

    test "deletes chosen client", %{conn: conn, client: client} do
      conn = delete(conn, ~p"/api/clients/#{client}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/clients/#{client}")
      end
    end
  end

  defp create_client(_) do
    client = client_fixture()
    %{client: client}
  end
end
