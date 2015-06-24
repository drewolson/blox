defmodule Blox.PostController do
  use Blox.Web, :controller

  alias Blox.Post

  plug :scrub_params, "post" when action in [:create, :update]
  plug :action

  def create(conn, %{"post" => params}) do
    changeset = Post.changeset(%Post{}, params)

    if changeset.valid? do
      post = Blox.Repo.insert!(changeset)
      redirect conn, to: post_path(conn, :show, post)
    else
      render conn, :new, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blox.Repo.get(Post, id)

    Blox.Repo.delete!(post)

    redirect conn, to: post_path(conn, :index)
  end

  def edit(conn, %{"id" => id}) do
    changeset = Post
    |> Blox.Repo.get(id)
    |> Post.changeset

    render conn, :edit,
      changeset: changeset
  end

  def index(conn, _params) do
    posts = Post
    |> Post.order_by_date
    |> Blox.Repo.all

    render conn, :index,
      posts: posts
  end

  def new(conn, _parms) do
    changeset = %Post{}
    |> Post.changeset

    render conn, :new,
      changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    post = Blox.Repo.get(Post, id)

    render conn, :show,
      post: post
  end

  def update(conn, %{"id" => id, "post" => params}) do
    changeset = Post
    |> Blox.Repo.get(id)
    |> Post.changeset(params)

    if changeset.valid? do
      post = Blox.Repo.update!(changeset)
      redirect conn, to: post_path(conn, :show, post)
    else
      render conn, :edit, changeset: changeset
    end
  end
end
