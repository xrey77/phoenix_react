defmodule PhoenixReact.UserdataTest do
  use PhoenixReact.DataCase

  alias PhoenixReact.Userdata

  describe "userprofiles" do
    alias PhoenixReact.Userdata.Userprofile

    import PhoenixReact.UserdataFixtures

    @invalid_attrs %{}

    test "list_userprofiles/0 returns all userprofiles" do
      userprofile = userprofile_fixture()
      assert Userdata.list_userprofiles() == [userprofile]
    end

    test "get_userprofile!/1 returns the userprofile with given id" do
      userprofile = userprofile_fixture()
      assert Userdata.get_userprofile!(userprofile.id) == userprofile
    end

    test "create_userprofile/1 with valid data creates a userprofile" do
      valid_attrs = %{}

      assert {:ok, %Userprofile{} = userprofile} = Userdata.create_userprofile(valid_attrs)
    end

    test "create_userprofile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Userdata.create_userprofile(@invalid_attrs)
    end

    test "update_userprofile/2 with valid data updates the userprofile" do
      userprofile = userprofile_fixture()
      update_attrs = %{}

      assert {:ok, %Userprofile{} = userprofile} = Userdata.update_userprofile(userprofile, update_attrs)
    end

    test "update_userprofile/2 with invalid data returns error changeset" do
      userprofile = userprofile_fixture()
      assert {:error, %Ecto.Changeset{}} = Userdata.update_userprofile(userprofile, @invalid_attrs)
      assert userprofile == Userdata.get_userprofile!(userprofile.id)
    end

    test "delete_userprofile/1 deletes the userprofile" do
      userprofile = userprofile_fixture()
      assert {:ok, %Userprofile{}} = Userdata.delete_userprofile(userprofile)
      assert_raise Ecto.NoResultsError, fn -> Userdata.get_userprofile!(userprofile.id) end
    end

    test "change_userprofile/1 returns a userprofile changeset" do
      userprofile = userprofile_fixture()
      assert %Ecto.Changeset{} = Userdata.change_userprofile(userprofile)
    end
  end
end
