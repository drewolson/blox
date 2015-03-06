defmodule Blox.PostView do
  use Blox.Web, :view

  def render("index.json", %{posts: posts}) do
    posts
  end

  def render("show.json", %{post: post}) do
    post
  end
end
