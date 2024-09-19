defmodule PhoenixReact.Userdata do

  import Ecto.Query, warn: false
  alias PhoenixReact.Repo
  alias PhoenixReact.Userdata.Userprofile

  def get_userprofile(id) do
    Repo.get!(Userprofile, id)    
  end

  def update_userprofile(%Userprofile{} = userprofile, attrs) do
    userprofile
    |> Userprofile.changeset(attrs)
    |> Repo.update()
  end

  def update_userpassword(%Userprofile{} = userprofile, attrs) do
    userprofile
    |> Userprofile.password_changeset(attrs)
    |> Repo.update()
  end

  def update_userpicture(%Userprofile{} = userprofile, attrs) do
    userprofile
    |> Userprofile.profilepic_changeset(attrs)
    |> Repo.update_all(set: [profilepic: attrs])
  end






  def list_userprofiles do
    Repo.all(Userprofile)
  end

  # def get_userprofile!(id), do: Repo.get!(Userprofile, id)

  def create_userprofile(attrs \\ %{}) do
    %Userprofile{}
    |> Userprofile.changeset(attrs)
    |> Repo.insert()
  end


  def delete_userprofile(%Userprofile{} = userprofile) do
    Repo.delete(userprofile)
  end

end
