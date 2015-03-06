defmodule Blox.Plug.CSRF do
  use Plug.Builder

  import Phoenix.Controller, only: [
    get_csrf_token: 0,
    protect_from_forgery: 2
  ]

  plug :protect_from_forgery
  plug :assign_csrf_token

  def assign_csrf_token(conn, _opts) do
    assign(conn, :csrf_token, get_csrf_token)
  end
end
