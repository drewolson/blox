defmodule Blox.HomeController do
  use Blox.Web, :controller

  def show(conn, _params) do
    render conn, :show
  end
end
