defmodule Ideatap.UserController do
  use Ideatap.Web, :controller
  alias Ideatap.{Repo, User, Auth}

  plug Ideatap.Plugs.Auth when action in [:show, :index]

  def index(conn, _params) do
    render conn, "index.json",
      users: Repo.all User
  end

  # Gets the current user based on the authorization token.
  def show(conn, %{"id" => "me"}) do
    render conn, "show.json",
      user: Auth.get_user_by_token(conn)
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.json",
      user: Repo.get User, id
  end

end
