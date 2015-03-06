defmodule Blox.HomeController do
  use Blox.Web, :controller

  plug :action

  def show(conn, _params) do
    render conn, :show
  end
end
