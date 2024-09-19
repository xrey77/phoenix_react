defmodule PhoenixReactWeb.Api.UserprofileJSON do
  alias PhoenixReact.Userdata.Userprofile

  @doc """
  Renders a list of userprofiles.
  """
  def index(%{userprofiles: userprofiles}) do
    %{data: for(userprofile <- userprofiles, do: data(userprofile))}
  end

  @doc """
  Renders a single userprofile.
  """
  def show(%{userprofile: userprofile}) do
    %{data: data(userprofile)}
  end

  defp data(%Userprofile{} = userprofile) do
    %{
      id: userprofile.id
    }
  end
end
