defmodule PhoenixReactWeb.PageController do
  use PhoenixReactWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
