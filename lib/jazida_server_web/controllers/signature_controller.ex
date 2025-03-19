defmodule JazidaServerWeb.SignatureController do
  use JazidaServerWeb, :controller

  @upload_dir "uploads/images"

  def upload(conn, %{"image" => %Plug.Upload{filename: filename, path: temp_path}}) do
    File.mkdir_p!(@upload_dir)
    uniquer_filename = "#{UUID.uuid4()}_#{filename}"

    destination_path = Path.join(@upload_dir, uniquer_filename)

    case File.cp(temp_path, destination_path) do
      :ok ->
        conn
        |> put_status(:created)
        |> json(%{message: "Upload successful", path: "/api/signature/#{uniquer_filename}"})

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Upload failed", reason: reason})
    end
  end

  def upload(conn, _params) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "No image file provided"})
  end

  def show(conn, %{"filename" => filename}) do
    image_path = Path.join(@upload_dir, filename)

    if File.exists?(image_path) do
      conn
      |> put_resp_content_type("image/png")
      |> send_file(200, image_path)
    else
      conn
      |> put_status(:not_found)
      |> json(%{error: "Image not found"})
    end
  end
end
