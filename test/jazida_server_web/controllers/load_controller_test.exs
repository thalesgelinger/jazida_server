defmodule JazidaServerWeb.LoadControllerTest do
  use JazidaServerWeb.ConnCase

  import JazidaServer.LoadsFixtures

  alias JazidaServer.Loads.Load

  @create_attrs %{
    quantity: 120.5,
    signature_path: "some signature_path"
  }
  @update_attrs %{
    quantity: 456.7,
    signature_path: "some updated signature_path"
  }
  @invalid_attrs %{quantity: nil, signature_path: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all loads", %{conn: conn} do
      conn = get(conn, ~p"/api/loads")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create load" do
    test "renders load when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/loads", load: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/loads/#{id}")

      assert %{
               "id" => ^id,
               "quantity" => 120.5,
               "signature_path" => "some signature_path"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/loads", load: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update load" do
    setup [:create_load]

    test "renders load when data is valid", %{conn: conn, load: %Load{id: id} = load} do
      conn = put(conn, ~p"/api/loads/#{load}", load: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/loads/#{id}")

      assert %{
               "id" => ^id,
               "quantity" => 456.7,
               "signature_path" => "some updated signature_path"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, load: load} do
      conn = put(conn, ~p"/api/loads/#{load}", load: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete load" do
    setup [:create_load]

    test "deletes chosen load", %{conn: conn, load: load} do
      conn = delete(conn, ~p"/api/loads/#{load}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/loads/#{load}")
      end
    end
  end

  defp create_load(_) do
    load = load_fixture()
    %{load: load}
  end
end
