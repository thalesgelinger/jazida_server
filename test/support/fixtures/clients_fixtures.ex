defmodule JazidaServer.ClientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JazidaServer.Clients` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> JazidaServer.Clients.create_client()

    client
  end

  @doc """
  Generate a plate.
  """
  def plate_fixture(attrs \\ %{}) do
    {:ok, plate} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> JazidaServer.Clients.create_plate()

    plate
  end
end
