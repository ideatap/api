defmodule Ideatap.IdeaController do
  use Ideatap.Web, :controller
  alias Ideatap.{Repo, Idea}

  plug :scrub_params, "idea" when action in [:create, :update]
  plug Ideatap.Plugs.Auth, "auth" when action in [:create, :update, :delete]

  def index(conn, _params) do
    render conn, "index.json", ideas: Repo.all Idea
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.json", idea: Repo.get Idea, id
  end

  def update(conn, %{"idea" => idea_params}) do
    changeset = Idea.changeset %Idea{}, idea_params
    case Repo.update changeset do
      {:ok, changeset} ->
        render conn, "show.json", idea: changeset
      {:error, changeset} ->
        # ERRORS!
    end
  end

  def create(conn, %{"idea" => idea_params}) do
    IO.inspect conn.assigns
    changeset = Idea.changeset %Idea{}, idea_params
    case Repo.insert changeset do
      {:ok, changeset} ->
        render conn, "show.json", idea: changeset
      {:error, changeset} ->
        # ERRORRS!
    end
  end

  def delete(conn, %{"id" => id}) do
    idea = Repo.get Idea, id
    case Repo.delete idea do
      {:ok, deleted} ->
        IO.inspect deleted
        render conn, "show.json", idea: deleted
      {:error, changeset} ->
        # ERRORS!
    end
  end

end
