defmodule JazidaServer.MaterialsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JazidaServer.Materials` context.
  """

  @doc """
  Generate a material.
  """
  def material_fixture(attrs \\ %{}) do
    {:ok, material} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> JazidaServer.Materials.create_material()

    material
  end
end
