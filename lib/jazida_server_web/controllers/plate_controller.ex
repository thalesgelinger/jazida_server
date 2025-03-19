defmodule JazidaServerWeb.PlateController do
  use JazidaServerWeb, :controller

  alias JazidaServer.Clients
  alias JazidaServer.Clients.Plate

  action_fallback JazidaServerWeb.FallbackController

  def index(conn, _params) do
    plates = Clients.list_plates()
    render(conn, :index, plates: plates)
  end

  def create(conn, %{"plate" => plate_params}) do
    with {:ok, %Plate{} = plate} <- Clients.create_plate(plate_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/plates/#{plate}")
      |> render(:show, plate: plate)
    end
  end

  def show(conn, %{"id" => id}) do
    plate = Clients.get_plate!(id)
    render(conn, :show, plate: plate)
  end

  def update(conn, %{"id" => id, "plate" => plate_params}) do
    plate = Clients.get_plate!(id)

    with {:ok, %Plate{} = plate} <- Clients.update_plate(plate, plate_params) do
      render(conn, :show, plate: plate)
    end
  end

  def delete(conn, %{"id" => id}) do
    plate = Clients.get_plate!(id)

    with {:ok, %Plate{}} <- Clients.delete_plate(plate) do
      send_resp(conn, :no_content, "")
    end
  end
end
