defmodule JazidaServer.Loads do
  @moduledoc """
  The Loads context.
  """

  import Ecto.Query, warn: false
  alias JazidaServer.Repo

  alias JazidaServer.Loads.Load

  @doc """
  Returns the list of loads.

  ## Examples

      iex> list_loads()
      [%Load{}, ...]

  """
  def list_loads do
    Repo.all(Load) |> Repo.preload([:client, :material, :plate])
  end

  @doc """
  Gets a single load.

  Raises `Ecto.NoResultsError` if the Load does not exist.

  ## Examples

      iex> get_load!(123)
      %Load{}

      iex> get_load!(456)
      ** (Ecto.NoResultsError)

  """
  def get_load!(id), do: Repo.get!(Load, id)

  @doc """
  Creates a load.

  ## Examples

      iex> create_load(%{field: value})
      {:ok, %Load{}}

      iex> create_load(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_load(attrs \\ %{}) do
    %Load{}
    |> Load.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, load} -> {:ok, Repo.preload(load, [:client, :material, :plate])}
      error -> error
    end
  end

  @doc """
  Updates a load.

  ## Examples

      iex> update_load(load, %{field: new_value})
      {:ok, %Load{}}

      iex> update_load(load, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_load(%Load{} = load, attrs) do
    load
    |> Load.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a load.

  ## Examples

      iex> delete_load(load)
      {:ok, %Load{}}

      iex> delete_load(load)
      {:error, %Ecto.Changeset{}}

  """
  def delete_load(%Load{} = load) do
    Repo.delete(load)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking load changes.

  ## Examples

      iex> change_load(load)
      %Ecto.Changeset{data: %Load{}}

  """
  def change_load(%Load{} = load, attrs \\ %{}) do
    Load.changeset(load, attrs)
  end
end
