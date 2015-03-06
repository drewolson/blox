defmodule Blox.ErrorView do
  use Blox.Web, :view

  def render("404.html", _assigns) do
    "Page not found - 404"
  end

  def render("500.html", _assigns) do
    "Server internal error - 500"
  end

  def template_not_found(_, assigns) do
    render "500.html", assigns
  end
end
