defmodule Blox.Endpoint do
  use Phoenix.Endpoint, otp_app: :blox

  plug Plug.Static,
    at: "/", from: :blox,
    only: ~w(css images js favicon.ico robots.txt)

  plug Plug.Logger

  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_blox_key",
    signing_salt: "thisisatestvalue"

  plug :router, Blox.Router
end
