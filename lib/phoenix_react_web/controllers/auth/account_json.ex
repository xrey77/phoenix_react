defmodule PhoenixReactWeb.Auth.AccountJSON do
  alias PhoenixReact.Accounts.Account

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(account <- users, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      firstname: account.firstname,
      lastname: account.lastname,
      emailadd: account.emailadd,
      mobileno: account.mobileno,
      username: account.username,
      password: account.password,
      profilepic: account.profilepic,
      role: account.role,
      qrcode: account.qrcode,
      completed: account.completed
    }
  end
end
