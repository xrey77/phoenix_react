defmodule PhoenixReactWeb.Router do
  use PhoenixReactWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PhoenixReactWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug :accepts, ["json"]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixReactWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/auth", PhoenixReactWeb.Auth, as: :auth do
    pipe_through :auth
    post "/signup", AccountController, :register    
    post "/signin", AccountController, :userlogin
  end

  scope "/api", PhoenixReactWeb.Api, as: :api do
    pipe_through :api
    get "/userid/:id", UserprofileController, :get_user_id
    patch "/user/update/:id", UserprofileController, :update_user
    patch "/user/update/password/:id", UserprofileController, :update_user_password
    post "/user/update/picture", UserprofileController, :update_user_picture
  end

  # Enable Swoosh mailbox preview in development
  # if Application.compile_env(:phoenix_react, :dev_routes) do

  #   scope "/dev" do
  #     pipe_through :browser

  #     forward "/mailbox", Plug.Swoosh.MailboxPreview
  #   end
  # end
end
