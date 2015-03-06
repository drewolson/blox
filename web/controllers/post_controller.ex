defmodule Blox.PostController do
  use Blox.Web, :controller

  alias Blox.Post

  plug :action

  def index(conn, _params) do
    posts = Post |> Blox.Repo.all

    render conn, :index,
      posts: posts
  end
end
