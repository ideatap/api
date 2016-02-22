defmodule Ideatap.UserController do
  use Ideatap.Web, :controller

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
  end

end
