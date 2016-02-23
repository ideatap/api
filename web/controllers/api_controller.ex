defmodule Ideatap.ApiController do
  use Ideatap.Web, :controller

  def index(conn, _params) do
    Plug.Conn.send_resp(conn, 401, "Not Authorized")
  end
end
