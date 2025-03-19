defmodule JazidaServer.ClientsTest do
  use JazidaServer.DataCase

  alias JazidaServer.Clients

  describe "clients" do
    alias JazidaServer.Clients.Client

    import JazidaServer.ClientsFixtures

    @invalid_attrs %{name: nil}

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Clients.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Clients.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Client{} = client} = Clients.create_client(valid_attrs)
      assert client.name == "some name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Client{} = client} = Clients.update_client(client, update_attrs)
      assert client.name == "some updated name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_client(client, @invalid_attrs)
      assert client == Clients.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Clients.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Clients.change_client(client)
    end
  end

  describe "plates" do
    alias JazidaServer.Clients.Plate

    import JazidaServer.ClientsFixtures

    @invalid_attrs %{name: nil}

    test "list_plates/0 returns all plates" do
      plate = plate_fixture()
      assert Clients.list_plates() == [plate]
    end

    test "get_plate!/1 returns the plate with given id" do
      plate = plate_fixture()
      assert Clients.get_plate!(plate.id) == plate
    end

    test "create_plate/1 with valid data creates a plate" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Plate{} = plate} = Clients.create_plate(valid_attrs)
      assert plate.name == "some name"
    end

    test "create_plate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_plate(@invalid_attrs)
    end

    test "update_plate/2 with valid data updates the plate" do
      plate = plate_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Plate{} = plate} = Clients.update_plate(plate, update_attrs)
      assert plate.name == "some updated name"
    end

    test "update_plate/2 with invalid data returns error changeset" do
      plate = plate_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_plate(plate, @invalid_attrs)
      assert plate == Clients.get_plate!(plate.id)
    end

    test "delete_plate/1 deletes the plate" do
      plate = plate_fixture()
      assert {:ok, %Plate{}} = Clients.delete_plate(plate)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_plate!(plate.id) end
    end

    test "change_plate/1 returns a plate changeset" do
      plate = plate_fixture()
      assert %Ecto.Changeset{} = Clients.change_plate(plate)
    end
  end
end
