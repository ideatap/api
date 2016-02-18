defmodule Ideatap.IdeaController do
  use Ideatap.Web, :controller
  alias Ideatap.{Repo, Idea}

  def index(conn, _params) do
    render conn, "index.json", ideas: Repo.all(Idea)
  end

  def show(conn, params) do
    IO.inspect params
  end

  def create(conn, params) do
    IO.inspect params
  end

  def delete(conn, id) do
    IO.puts id
  end

end
