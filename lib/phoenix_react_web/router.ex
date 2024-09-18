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

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixReactWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/auth", PhoenixReactWeb.Auth, as: :api do
    pipe_through :api

    post "/signup", AccountController, :register    
    post "/signin", AccountController, :userlogin
  end

  # Enable Swoosh mailbox preview in development
  # if Application.compile_env(:phoenix_react, :dev_routes) do

  #   scope "/dev" do
  #     pipe_through :browser

  #     forward "/mailbox", Plug.Swoosh.MailboxPreview
  #   end
  # end
end
