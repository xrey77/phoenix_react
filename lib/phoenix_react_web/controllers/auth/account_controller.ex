defmodule PhoenixReactWeb.Auth.AccountController do
  use PhoenixReactWeb, :controller
  alias PhoenixReact.{Accounts}

  action_fallback PhoenixReactWeb.FallbackController


  def register(conn, %{"account" => account_params}) do
    if Accounts.get_account_by_email(account_params["emailadd"]) do
      conn |> json([%{statuscode: 400, message: "Email Address has already taken."}])      
    else

      if Accounts.get_account_by_username(account_params["username"]) do
        conn |> json([%{statuscode: 400, message: "User name has already taken."}])      
      else

          if Accounts.create_account(account_params) do
            conn |> json([%{statuscode: 201, message: "Your account has been created successfully...", account: account_params["emailadd"]}])
          else
            conn |> json([%{statuscode: 400, message: "Unable to create account"}])      
          end
  
      end

    end
  end

  defp authorize_user(conn, emailadd, password) do
    case PhoenixReactWeb.Auth.Guardian.authenticate(emailadd, password) do
      {:ok, account, token} ->
        conn
        |> json([%{statuscode: 201,
                  message: "You have successfully logged in, pls wait.",
                  id: account.id,
                  firstname: account.firstname,
                  lastname: account.lastname,
                  emailadd: account.emailadd,
                  profilepic: account.profilepic,
                  role: account.role,
                  otp: account.qrcode,
                  token: token}])
      {:error, :no_content} -> conn |> json(%{statuscode: 400, message: "Invalid Credentials, pls try again."})
    end
  end

  def userlogin(conn, %{"emailadd" => emailadd, "password" => password}) do
    usr = Accounts.get_account_by_email(emailadd)
    if usr do
      if Accounts.validated_password(password, usr.password) do
        authorize_user(conn,emailadd, password)
      else
        conn |> json([%{statuscode: 400, message: "Invalid Password"}])
      end
    else
      conn |> json([%{statuscode: 400, message: "Invalid Email Address"}])
    end
  end

end
