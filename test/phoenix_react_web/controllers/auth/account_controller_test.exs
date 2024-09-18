defmodule PhoenixReactWeb.Auth.AccountControllerTest do
  use PhoenixReactWeb.ConnCase

  import PhoenixReact.AccountsFixtures

  alias PhoenixReact.Accounts.Account

  @create_attrs %{
    username: "some username",
    password: "some password",
    role: "some role",
    completed: true,
    firstname: "some firstname",
    lastname: "some lastname",
    emailadd: "some emailadd",
    mobileno: "some mobileno",
    profilepic: "some profilepic",
    qrcode: "some qrcode"
  }
  @update_attrs %{
    username: "some updated username",
    password: "some updated password",
    role: "some updated role",
    completed: false,
    firstname: "some updated firstname",
    lastname: "some updated lastname",
    emailadd: "some updated emailadd",
    mobileno: "some updated mobileno",
    profilepic: "some updated profilepic",
    qrcode: "some updated qrcode"
  }
  @invalid_attrs %{username: nil, password: nil, role: nil, completed: nil, firstname: nil, lastname: nil, emailadd: nil, mobileno: nil, profilepic: nil, qrcode: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, ~p"/api/auth/users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/auth/users", account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/auth/users/#{id}")

      assert %{
               "id" => ^id,
               "completed" => true,
               "emailadd" => "some emailadd",
               "firstname" => "some firstname",
               "lastname" => "some lastname",
               "mobileno" => "some mobileno",
               "password" => "some password",
               "profilepic" => "some profilepic",
               "qrcode" => "some qrcode",
               "role" => "some role",
               "username" => "some username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/auth/users", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put(conn, ~p"/api/auth/users/#{account}", account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/auth/users/#{id}")

      assert %{
               "id" => ^id,
               "completed" => false,
               "emailadd" => "some updated emailadd",
               "firstname" => "some updated firstname",
               "lastname" => "some updated lastname",
               "mobileno" => "some updated mobileno",
               "password" => "some updated password",
               "profilepic" => "some updated profilepic",
               "qrcode" => "some updated qrcode",
               "role" => "some updated role",
               "username" => "some updated username"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/api/auth/users/#{account}", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, ~p"/api/auth/users/#{account}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/auth/users/#{account}")
      end
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end
