defmodule PhoenixReact.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixReact.Accounts` context.
  """

  @doc """
  Generate a unique account emailadd.
  """
  def unique_account_emailadd, do: "some emailadd#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique account username.
  """
  def unique_account_username, do: "some username#{System.unique_integer([:positive])}"

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        completed: true,
        emailadd: unique_account_emailadd(),
        firstname: "some firstname",
        lastname: "some lastname",
        mobileno: "some mobileno",
        password: "some password",
        profilepic: "some profilepic",
        qrcode: "some qrcode",
        role: "some role",
        username: unique_account_username()
      })
      |> PhoenixReact.Accounts.create_account()

    account
  end
end
