defmodule PhoenixReact.UserdataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixReact.Userdata` context.
  """

  @doc """
  Generate a userprofile.
  """
  def userprofile_fixture(attrs \\ %{}) do
    {:ok, userprofile} =
      attrs
      |> Enum.into(%{

      })
      |> PhoenixReact.Userdata.create_userprofile()

    userprofile
  end
end
