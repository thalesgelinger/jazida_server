defmodule JazidaServer.LoadsTest do
  use JazidaServer.DataCase

  alias JazidaServer.Loads

  describe "loads" do
    alias JazidaServer.Loads.Load

    import JazidaServer.LoadsFixtures

    @invalid_attrs %{quantity: nil, signature_path: nil}

    test "list_loads/0 returns all loads" do
      load = load_fixture()
      assert Loads.list_loads() == [load]
    end

    test "get_load!/1 returns the load with given id" do
      load = load_fixture()
      assert Loads.get_load!(load.id) == load
    end

    test "create_load/1 with valid data creates a load" do
      valid_attrs = %{quantity: 120.5, signature_path: "some signature_path"}

      assert {:ok, %Load{} = load} = Loads.create_load(valid_attrs)
      assert load.quantity == 120.5
      assert load.signature_path == "some signature_path"
    end

    test "create_load/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Loads.create_load(@invalid_attrs)
    end

    test "update_load/2 with valid data updates the load" do
      load = load_fixture()
      update_attrs = %{quantity: 456.7, signature_path: "some updated signature_path"}

      assert {:ok, %Load{} = load} = Loads.update_load(load, update_attrs)
      assert load.quantity == 456.7
      assert load.signature_path == "some updated signature_path"
    end

    test "update_load/2 with invalid data returns error changeset" do
      load = load_fixture()
      assert {:error, %Ecto.Changeset{}} = Loads.update_load(load, @invalid_attrs)
      assert load == Loads.get_load!(load.id)
    end

    test "delete_load/1 deletes the load" do
      load = load_fixture()
      assert {:ok, %Load{}} = Loads.delete_load(load)
      assert_raise Ecto.NoResultsError, fn -> Loads.get_load!(load.id) end
    end

    test "change_load/1 returns a load changeset" do
      load = load_fixture()
      assert %Ecto.Changeset{} = Loads.change_load(load)
    end
  end
end
