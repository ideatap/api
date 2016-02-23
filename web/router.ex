defmodule Ideatap.Router do
  use Ideatap.Web, :router
  require Ueberauth

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  scope "/api", Ideatap do
    pipe_through :api

    get "/", ApiController, :index

    resources "/users", UserController, only: [:show, :index]
    resources "/ideas", IdeaController
  end

  # Auth needs :browser pipeline since it's being accessed via a popup from ember
  scope "/auth", Ideatap do
    pipe_through :browser

    post "/logout", AuthController, :logout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end
end
