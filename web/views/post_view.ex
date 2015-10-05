defmodule Blox.PostView do
  use Blox.Web, :view

  def render("index.json", %{page: page}) do
    page.entries
  end

  def render("show.json", %{post: post}) do
    post
  end
end
