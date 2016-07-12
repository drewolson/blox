defmodule Blox.PostController do
  use Blox.Web, :controller

  alias Blox.Comment
  alias Blox.Post

  plug :scrub_params, "post" when action in [:create, :update]

  def create(conn, %{"post" => params}) do
    changeset = Post.changeset(%Post{}, params)

    case Blox.Repo.insert(changeset) do
      {:ok, post} ->
        redirect conn, to: post_path(conn, :show, post)

      {:error, changeset} ->
        render conn, :new, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    Post
    |> Blox.Repo.get(id)
    |> Blox.Repo.delete!

    redirect conn, to: post_path(conn, :index)
  end

  def edit(conn, %{"id" => id}) do
    changeset =
      Post
      |> Blox.Repo.get(id)
      |> Post.changeset

    render conn, :edit,
      changeset: changeset
  end

  def index(conn, _params) do
    posts =
      Post
      |> Post.order_by_date
      |> Post.with_comments
      |> Blox.Repo.all

    render conn, :index,
      posts: posts
  end

  def new(conn, _parms) do
    changeset = Post.changeset(%Post{})

    render conn, :new,
      changeset: changeset
  end

  def show(conn, %{"id" => id}) do
    post =
      Post
      |> Post.with_comments
      |> Blox.Repo.get(id)

    new_comment =
      post
      |> build_assoc(:comments)
      |> Comment.changeset

    render conn, :show,
      new_comment: new_comment,
      post: post
  end

  def update(conn, %{"id" => id, "post" => params}) do
    changeset =
      Post
      |> Blox.Repo.get(id)
      |> Post.changeset(params)

    case Blox.Repo.update(changeset) do
      {:ok, post} ->
        redirect conn, to: post_path(conn, :show, post)

      {:error, changeset} ->
        render conn, :edit, changeset: changeset
    end
  end
end
