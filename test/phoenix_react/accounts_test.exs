defmodule PhoenixReact.AccountsTest do
  use PhoenixReact.DataCase

  alias PhoenixReact.Accounts

  describe "users" do
    alias PhoenixReact.Accounts.Account

    import PhoenixReact.AccountsFixtures

    @invalid_attrs %{username: nil, password: nil, role: nil, completed: nil, firstname: nil, lastname: nil, emailadd: nil, mobileno: nil, profilepic: nil, qrcode: nil}

    test "list_users/0 returns all users" do
      account = account_fixture()
      assert Accounts.list_users() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{username: "some username", password: "some password", role: "some role", completed: true, firstname: "some firstname", lastname: "some lastname", emailadd: "some emailadd", mobileno: "some mobileno", profilepic: "some profilepic", qrcode: "some qrcode"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.username == "some username"
      assert account.password == "some password"
      assert account.role == "some role"
      assert account.completed == true
      assert account.firstname == "some firstname"
      assert account.lastname == "some lastname"
      assert account.emailadd == "some emailadd"
      assert account.mobileno == "some mobileno"
      assert account.profilepic == "some profilepic"
      assert account.qrcode == "some qrcode"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{username: "some updated username", password: "some updated password", role: "some updated role", completed: false, firstname: "some updated firstname", lastname: "some updated lastname", emailadd: "some updated emailadd", mobileno: "some updated mobileno", profilepic: "some updated profilepic", qrcode: "some updated qrcode"}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.username == "some updated username"
      assert account.password == "some updated password"
      assert account.role == "some updated role"
      assert account.completed == false
      assert account.firstname == "some updated firstname"
      assert account.lastname == "some updated lastname"
      assert account.emailadd == "some updated emailadd"
      assert account.mobileno == "some updated mobileno"
      assert account.profilepic == "some updated profilepic"
      assert account.qrcode == "some updated qrcode"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
