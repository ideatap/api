defmodule Ideatap.Endpoint do
  use Phoenix.Endpoint, otp_app: :ideatap

  socket "/socket", Ideatap.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :ideatap, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_ideatap_key",
    signing_salt: "m3zy6quX"

  # Move to config
  plug CORSPlug, origin: Application.get_env(:ideatap, :cors_origin)

  plug Ideatap.Router
end
