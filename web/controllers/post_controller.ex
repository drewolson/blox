defmodule Blox.PostController do
  use Blox.Web, :controller

  alias Blox.Post

  plug :action

  def index(conn, _params) do
    posts = Post
    |> Post.order_by_date
    |> Blox.Repo.all

    render conn, :index,
      posts: posts
  end

  def show(conn, %{"id" => id}) do
    post = Blox.Repo.get(Post, id)

    render conn, :show,
      post: post
  end
end
