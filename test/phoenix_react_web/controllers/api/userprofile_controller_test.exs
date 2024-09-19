defmodule PhoenixReactWeb.Api.UserprofileControllerTest do
  use PhoenixReactWeb.ConnCase

  import PhoenixReact.UserdataFixtures

  alias PhoenixReact.Userdata.Userprofile

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all userprofiles", %{conn: conn} do
      conn = get(conn, ~p"/api/api/userprofiles")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create userprofile" do
    test "renders userprofile when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/userprofiles", userprofile: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/userprofiles/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/userprofiles", userprofile: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update userprofile" do
    setup [:create_userprofile]

    test "renders userprofile when data is valid", %{conn: conn, userprofile: %Userprofile{id: id} = userprofile} do
      conn = put(conn, ~p"/api/api/userprofiles/#{userprofile}", userprofile: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/userprofiles/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, userprofile: userprofile} do
      conn = put(conn, ~p"/api/api/userprofiles/#{userprofile}", userprofile: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete userprofile" do
    setup [:create_userprofile]

    test "deletes chosen userprofile", %{conn: conn, userprofile: userprofile} do
      conn = delete(conn, ~p"/api/api/userprofiles/#{userprofile}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/userprofiles/#{userprofile}")
      end
    end
  end

  defp create_userprofile(_) do
    userprofile = userprofile_fixture()
    %{userprofile: userprofile}
  end
end
