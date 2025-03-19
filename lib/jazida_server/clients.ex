defmodule JazidaServer.Clients do
  @moduledoc """
  The Clients context.
  """

  import Ecto.Query, warn: false
  alias JazidaServer.Repo

  alias JazidaServer.Clients.Client

  @doc """
  Returns the list of clients.

  ## Examples

      iex> list_clients()
      [%Client{}, ...]

  """
  def list_clients do
    Repo.all(Client)
  end

  @doc """
  Gets a single client.

  Raises `Ecto.NoResultsError` if the Client does not exist.

  ## Examples

      iex> get_client!(123)
      %Client{}

      iex> get_client!(456)
      ** (Ecto.NoResultsError)

  """
  def get_client!(id), do: Repo.get!(Client, id)

  @doc """
  Creates a client.

  ## Examples

      iex> create_client(%{field: value})
      {:ok, %Client{}}

      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a client.

  ## Examples

      iex> update_client(client, %{field: new_value})
      {:ok, %Client{}}

      iex> update_client(client, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_client(%Client{} = client, attrs) do
    client
    |> Client.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a client.

  ## Examples

      iex> delete_client(client)
      {:ok, %Client{}}

      iex> delete_client(client)
      {:error, %Ecto.Changeset{}}

  """
  def delete_client(%Client{} = client) do
    Repo.delete(client)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking client changes.

  ## Examples

      iex> change_client(client)
      %Ecto.Changeset{data: %Client{}}

  """
  def change_client(%Client{} = client, attrs \\ %{}) do
    Client.changeset(client, attrs)
  end

  alias JazidaServer.Clients.Plate

  @doc """
  Returns the list of plates.

  ## Examples

      iex> list_plates()
      [%Plate{}, ...]

  """
  def list_plates do
    Repo.all(Plate) |> Repo.preload(:client)
  end

  @doc """
  Gets a single plate.

  Raises `Ecto.NoResultsError` if the Plate does not exist.

  ## Examples

      iex> get_plate!(123)
      %Plate{}

      iex> get_plate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_plate!(id), do: Repo.get!(Plate, id)

  @doc """
  Creates a plate.

  ## Examples

      iex> create_plate(%{field: value})
      {:ok, %Plate{}}

      iex> create_plate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_plate(attrs \\ %{}) do
    %Plate{}
    |> Plate.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, plate} -> {:ok, Repo.preload(plate, :client)}
      error -> error
    end
  end

  @doc """
  Updates a plate.

  ## Examples

      iex> update_plate(plate, %{field: new_value})
      {:ok, %Plate{}}

      iex> update_plate(plate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_plate(%Plate{} = plate, attrs) do
    plate
    |> Plate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a plate.

  ## Examples

      iex> delete_plate(plate)
      {:ok, %Plate{}}

      iex> delete_plate(plate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_plate(%Plate{} = plate) do
    Repo.delete(plate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking plate changes.

  ## Examples

      iex> change_plate(plate)
      %Ecto.Changeset{data: %Plate{}}

  """
  def change_plate(%Plate{} = plate, attrs \\ %{}) do
    Plate.changeset(plate, attrs)
  end
end
