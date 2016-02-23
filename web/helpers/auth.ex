defmodule Ideatap.Helpers.Auth do

  import Plug.Conn

  @doc """
  Fetches the `Authorization` header from the request and gets the token.
  """
  def get_token(conn) do
    get_req_header(conn, "authorization") |> token_from_header()
  end

  @doc """
  Checks if there is a `Bearer <token>` in the authorization header.
  """
  def token_from_header(["Bearer " <> token]), do: %{token: token}
  def token_from_header(_), do: %{error: "Not Present"}

end
