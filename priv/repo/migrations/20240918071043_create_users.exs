defmodule PhoenixReact.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :emailadd, :string
      add :mobileno, :string
      add :username, :string
      add :password, :string
      add :profilepic, :string
      add :role, :string
      add :qrcode, :text
      add :completed, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:emailadd])
  end
end
