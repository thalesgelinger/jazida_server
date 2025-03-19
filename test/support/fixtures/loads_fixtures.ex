defmodule JazidaServer.LoadsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JazidaServer.Loads` context.
  """

  @doc """
  Generate a load.
  """
  def load_fixture(attrs \\ %{}) do
    {:ok, load} =
      attrs
      |> Enum.into(%{
        quantity: 120.5,
        signature_path: "some signature_path"
      })
      |> JazidaServer.Loads.create_load()

    load
  end
end
