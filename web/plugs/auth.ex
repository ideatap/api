defmodule Ideatap.Plugs.Auth do
  import Plug.Conn
  import Ecto.Query, only: [from: 2]

  alias Ideatap.{Repo, User}


  def init(opts), do: opts
  def call(conn, _params) do
    IO.inspect conn
    case check_token(conn, get_token(conn)) do
      {:ok, user} -> assign(conn, :authenticated_user, user)
      {:error, message} -> send_resp(conn, 401, "Not Authorized") |> halt()
      nil ->
        IO.puts "something is nil"
        conn
    end
  end

  @doc """
  Checks whether the token passed is assigned to a user and the id is correct.

  `Phoenix.Token.verify/3` is necessary to get the user id from the signed token.
  """
  def check_token(conn, %{error: message}), do: {:error, "Not Authorized"}
  def check_token(conn, %{token: token}) do
    case validates_token(conn, token) do
      {:ok, token, data} -> check_token_is_known(token, data)
      {:error, message} -> {:error, message}
    end
  end

  def check_token_is_known(token, data) do
    query = from u in User, where: u.id == ^data and
        fragment("? @> ?", u.authentication_tokens, ^[token])

    case Repo.one(query) do
      nil -> {:error, :unknown_token}
      user -> {:ok, user}
    end
  end

  def validates_token(conn, token) do
    IO.inspect Phoenix.Token.verify(conn, "user", token)
    case Phoenix.Token.verify(conn, "user", token) do
      {:ok, data} -> {:ok, token, data}
      {:error, _} -> {:error, "Not Valid"}
    end
  end

  # def check_token(conn, {:error, _message}), do: {:error, "Not Authorized"}
  # def check_token(conn, {:ok, token}) do
  #   {:ok, id} = Phoenix.Token.verify(conn, "user", token)
  #   query = from u in User,
  #     where: u.id == ^id and
  #     fragment("? @> ?", u.authentication_tokens, ^[token])
  #
  #   case Repo.one(query) do
  #     nil -> {:error, :unknown_token}
  #     user -> {:ok, user}
  #   end
  # end

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
