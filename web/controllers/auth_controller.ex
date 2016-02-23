defmodule Ideatap.AuthController do
  use Ideatap.Web, :controller
  alias Ideatap.Auth
  alias Ueberauth.Strategy.Twitter

  plug Ueberauth

  # Redirect to twitter
  def request(conn, _params), do: Twitter.handle_request!(conn)

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Auth.find_or_create_user(auth) do
      {:ok, user} -> finish_callback(conn, %{user: user})
      {:error, reason} -> finish_callback(conn, %{error: reason})
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    IO.puts "failed for some reason..."
    conn |> halt
  end

  def get_redirect_path(token) do
    redirect_path = Application.get_env(:ideatap, :callback_redirect)
    query = URI.encode_query %{"code" => token}
    "#{redirect_path}/?#{query}"
  end

  defp finish_callback(conn, %{user: user}) do
    {:ok, token} = Auth.assign_token(conn, user)
    IO.inspect get_redirect_path(token)
    conn
    |> redirect(external: get_redirect_path(token))
    |> halt()
  end

  # TODO: figure out how ember will need to handle errors
  defp finish_callback(conn, %{error: _reason}) do
    conn |> halt()
  end

  def logout(conn, _params) do
    # This should remove the token in the Authorization header from the users account.
    conn
  end

end
