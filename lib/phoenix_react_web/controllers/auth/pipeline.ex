defmodule PhoenixReactWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :real_deal_api,
  module: PhoenixReactWeb.Auth.Guardian,
  error_handler: PhoenixReactWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
