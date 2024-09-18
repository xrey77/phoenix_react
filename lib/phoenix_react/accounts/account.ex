defmodule PhoenixReact.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :role, :string
    field :completed, :boolean, default: false
    field :firstname, :string
    field :lastname, :string
    field :emailadd, :string
    field :mobileno, :string
    field :profilepic, :string
    field :qrcode, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:firstname, :lastname, :emailadd, :mobileno, :username, :password, :profilepic, :role, :qrcode, :completed])
    |> validate_required([:firstname, :lastname, :emailadd, :mobileno, :username, :password, :role, :completed])
    |> unique_constraint(:username)
    |> unique_constraint(:emailadd)
    |> put_password_hash()
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.Base.hash_password(password, Bcrypt.Base.gen_salt(12, true)))
  end

  defp put_password_hash(changeset), do: changeset

end
