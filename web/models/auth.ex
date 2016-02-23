defmodule Ideatap.Auth do

  # TODO: better error handling
  # TODO: once again, better error handling
  # TODO: add the users token and secret to their account, so we can use the TWITTER api

  import Ecto.Query, only: [from: 2]

  alias Ecto.Changeset
  alias Ideatap.{User, Repo}
  alias Ideatap.Helpers

  def find_or_create_user(%Ueberauth.Auth{} = auth) do
    basic_info = get_basic_info(auth)
    case User.find_by_username basic_info.username do
      nil -> create_user(basic_info)
      {:ok, user} -> {:ok, user}
    end
  end

  def assign_token(conn, user) do
    token = Phoenix.Token.sign(conn, "user", user.id)
    Changeset.cast(user, %{}, [])
    |> Changeset.put_change(:authentication_tokens, [token | user.authentication_tokens])
    |> Repo.update!

    {:ok, token}
  end

  def get_user_by_token(conn) do
    ["Bearer " <> token] = Plug.Conn.get_req_header(conn, "authorization")
    {:ok, id} = Phoenix.Token.verify(conn, "user", token)
    query = from u in User, where: u.id == ^id
    Repo.one query
  end

  def create_user(info) do
    changeset = User.changeset %User{}, %{
      username: info.username,
      bio: info.bio,
      image_url: info.image
    }

    Repo.insert changeset
  end

  @doc """
  Returns some basic information about the user from a `Ueberauth.Auth` struct.
  """
  def get_basic_info(auth) do
    %{username: auth.info.nickname,
      bio: auth.info.description,
      image: auth.info.image,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret}
  end

end
