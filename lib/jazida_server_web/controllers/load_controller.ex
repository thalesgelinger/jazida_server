defmodule JazidaServerWeb.LoadController do
  use JazidaServerWeb, :controller

  alias JazidaServer.Notification
  alias JazidaServer.Loads
  alias JazidaServer.Loads.Load

  action_fallback JazidaServerWeb.FallbackController

  def index(conn, _params) do
    loads = Loads.list_loads()
    render(conn, :index, loads: loads)
  end

  def create(conn, %{"load" => load_params}) do
    with {:ok, %Load{} = load} <- Loads.create_load(load_params) do
      Notification.push(load)

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/loads/#{load}")
      |> render(:show, load: load)
    end
  end

  def show(conn, %{"id" => id}) do
    load = Loads.get_load!(id)
    render(conn, :show, load: load)
  end

  def update(conn, %{"id" => id, "load" => load_params}) do
    load = Loads.get_load!(id)

    with {:ok, %Load{} = load} <- Loads.update_load(load, load_params) do
      render(conn, :show, load: load)
    end
  end

  def delete(conn, %{"id" => id}) do
    load = Loads.get_load!(id)

    with {:ok, %Load{}} <- Loads.delete_load(load) do
      send_resp(conn, :no_content, "")
    end
  end
end
