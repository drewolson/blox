defmodule Blox.CommentController do
  use Blox.Web, :controller

  alias Blox.Comment
  alias Blox.Post

  plug :scrub_params, "comment" when action in [:create]
  plug :find_post

  def create(conn, %{"comment" => params}) do
    changeset =
      conn.assigns[:post]
      |> build_assoc(:comments)
      |> Comment.changeset(params)

    case Blox.Repo.insert(changeset) do
      {:ok, comment} ->
        redirect conn, to: post_path(conn, :show, comment.post_id)

      {:error, changeset} ->
        render conn, :new, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    post = conn.assigns[:post]

    post
    |> assoc(:comments)
    |> Blox.Repo.get(id)
    |> Blox.Repo.delete!

    redirect conn, to: post_path(conn, :show, post)
  end

  def find_post(conn, _opts) do
    post = Blox.Repo.get(Post, conn.params["post_id"])

    if post do
      assign(conn, :post, post)
    else
      conn
      |> put_flash(:error, "Post not found")
      |> redirect(to: post_path(conn, :index))
      |> halt
    end
  end
end
