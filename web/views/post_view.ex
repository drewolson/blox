defmodule Blox.PostView do
  use Blox.Web, :view

  def render("show.json", %{post: post}) do
    post
  end
end
