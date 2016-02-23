defmodule Ideatap.AuthController do
  use Ideatap.Web, :controller
  plug Ueberauth

  alias Ideatap.Auth
  alias Ueberauth.Strategy.Twitter

  # Redirect to twitter
  def request(conn, _params), do: Twitter.handle_request!(conn)

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    case Auth.find_or_create_user(auth) do
      {:ok, user} -> finish_callback(conn, %{user: user})
      {:error, reason} -> finish_callback(conn, %{error: reason})
    end
  end

  defp finish_callback(conn, %{user: user}) do
    redirect_path = Application.get_env(:ideatap, :callback_redirect)
    token = Phoenix.Token.sign(conn, "user", user.id)
    conn
    |> redirect(external: "#{redirect_path}/?code=#{token}")
    |> halt()
  end

  # TODO: figure out how ember will need to handle errors
  defp finish_callback(conn, %{error: _reason}) do
    conn |> halt()
  end

  def callback(%{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    IO.puts "failed for some reason..."
    IO.inspect fails
    conn |> halt
  end

  def logout(conn, _params) do
    # Revoke access to the token.
    conn |> halt
  end

end
