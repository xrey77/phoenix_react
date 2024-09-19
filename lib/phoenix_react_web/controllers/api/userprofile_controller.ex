defmodule PhoenixReactWeb.Api.UserprofileController do
    use PhoenixReactWeb, :controller
    # import Mogrify
  
    alias PhoenixReact.Userdata
    # alias PhoenixReact.Userdata.Userprofile
  
    action_fallback PhoenixReactWeb.FallbackController
  
    def get_user_id(conn, %{"id" => id}) do
      userprofile = Userdata.get_userprofile(id)
      conn |> json([%{
        firstname: userprofile.firstname,
        lastname: userprofile.lastname,
        emailadd: userprofile.emailadd,
        mobileno: userprofile.mobileno,
        role: userprofile.role,
        qrcode: userprofile.qrcode,
        profilepic: userprofile.profilepic,
        statuscode: 201,
        message: "Your profile has been successfully retrieved."
        }])
    end
  
    def update_user(conn, %{"id" => id, "user" => user_params}) do
      if Userdata.get_userprofile(id) do
          userprofile = Userdata.get_userprofile(id)
          Userdata.update_userprofile(userprofile, user_params)
          conn |> json([%{statuscode: 201, message: "User profile updated successfully."}])
      else
        conn |> json([%{statuscode: 400, message: "User profile not found"}])
      end
    end
  
    def update_user_password(conn, %{"id" => id, "user" => user_params}) do
      if Userdata.get_userprofile(id) do
        userprofile = Userdata.get_userprofile(id)
        Userdata.update_userpassword(userprofile, user_params)
        conn |> json([%{statuscode: 201, message: "User password updated successfully."}])
      else
        conn |> json([%{statuscode: 400, message: "User profile not found"}])
      end
    end
  
    def update_user_picture(conn, params) do
      if upload = params["profilepic"] do

        idno = params["id"]  

        if Userdata.get_userprofile(idno) do

          extension = Path.extname(upload.filename)
          newfilename = "000" <> idno <> extension     

          dbfilename = "/images/users/"<> newfilename
          userprofile = Userdata.get_userprofile(idno)
          Userdata.update_userprofile(userprofile, %{profilepic: dbfilename})    
          File.cp(upload.path, Path.absname("./priv/static/images/users/#{newfilename}"))
          conn |> json(%{statuscode: 201, message: "Profile picture has been changed..."})                    
        else
          conn |> json(%{message: "Failed to uploaded..."})
      end

  #        xfile = Path.absname(upload.filename)      
  #        open(xfile)
  #        |> auto_orient()
  #        |> resize("100x100")
  #        |> save()        
      end
    end
  
  
  
    # def index(conn, _params) do
    #   userprofiles = Userdata.list_userprofiles()
    #   render(conn, :index, userprofiles: userprofiles)
    # end
  
    # def create(conn, %{"userprofile" => userprofile_params}) do
    #   with {:ok, %Userprofile{} = userprofile} <- Userdata.create_userprofile(userprofile_params) do
    #     conn
    #     |> put_status(:created)
    #     |> render(:show, userprofile: userprofile)
    #   end
    # end
  
    # def show(conn, %{"id" => id}) do
    #   userprofile = Userdata.get_userprofile!(id)
    #   render(conn, :show, userprofile: userprofile)
    # end
  
    # def update(conn, %{"id" => id, "userprofile" => userprofile_params}) do
    #   userprofile = Userdata.get_userprofile!(id)
  
    #   with {:ok, %Userprofile{} = userprofile} <- Userdata.update_userprofile(userprofile, userprofile_params) do
    #     render(conn, :show, userprofile: userprofile)
    #   end
    # end
  
    # def delete(conn, %{"id" => id}) do
    #   userprofile = Userdata.get_userprofile!(id)
  
    #   with {:ok, %Userprofile{}} <- Userdata.delete_userprofile(userprofile) do
    #     send_resp(conn, :no_content, "")
    #   end
    # end
  end
  