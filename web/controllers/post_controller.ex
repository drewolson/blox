defmodule Blox.PostController do
  use Blox.Web, :controller

  alias Blox.Post

  plug :action

  def create(conn, %{"post" => params}) do
    post = %Post{
      title: params["title"],
      body: params["body"]
    } |> Blox.Repo.insert

    redirect conn, to: post_path(conn, :show, post.id)
  end

  def index(conn, _params) do
    posts = Post
    |> Post.order_by_date
    |> Blox.Repo.all

    render conn, :index,
      posts: posts
  end

  def new(conn, _parms) do
    render conn, :new,
      post: %Post{}
  end

  def show(conn, %{"id" => id}) do
    post = Blox.Repo.get(Post, id)

    render conn, :show,
      post: post
  end
end
