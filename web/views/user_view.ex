defmodule Ideatap.UserView do
  use Ideatap.Web, :view

  def render("index.json", %{users: users}) do
    %{users: render_many(users, Ideatap.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{user: render_one(user, Ideatap.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      image_url: user.image_url,
      first_name: user.first_name,
      last_name: user.last_name}
  end
end
