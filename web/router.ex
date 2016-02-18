defmodule Ideatap.Router do
  use Ideatap.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Ideatap do
    pipe_through :api

    resources "/ideas", IdeaController
  end
end
