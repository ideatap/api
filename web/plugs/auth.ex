defmodule Ideatap.Plugs.Auth do
  import Plug.Conn
  import Ecto.Query, only: [from: 2]

  alias Ideatap.{Repo, User}

  def init(opts), do: opts

  def call(conn, params) do
    case check_token(token_from_conn(conn)) do
      {:ok, user} -> assign(conn, :authenticated_user, user)
      {:error, message} -> send_resp(conn, 401, "Not Authorized") |> halt()
    end
  end


  def check_token({:ok, token}) do
    check_token_is_known(token)
  end

  def check_token(_), do: {:error, "Not Authorized"}

  # is token present in any user?
  def check_token_is_known(token) do
    user_id = Phoenix.Token.verify
    query = from u in User,
      where: u.id ==
  end

  def token_from_conn(conn) do
    get_req_header(conn, "authorization") |> token_from_header()
  end

  def token_from_header(["Bearer " <> token]), do: {:ok, token}
  def token_from_header(_), do: {:error, :not_present}

end
