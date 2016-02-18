defmodule Ideatap.IdeaView do
  use Ideatap.Web, :view

  def render("index.json", %{ideas: ideas}) do
    %{ideas: render_many(ideas, Ideatap.IdeaView, "idea.json")}
  end

  def render("show.json", %{idea: idea}) do
    %{idea: render_one(idea, Ideatap.IdeaView, "idea.json")}
  end

  def render("idea.json", %{idea: idea}) do
    %{id: idea.id,
      title: idea.title,
      description: idea.description}
  end

end
