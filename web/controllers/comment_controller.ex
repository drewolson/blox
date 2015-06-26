defmodule Blox.CommentController do
  use Blox.Web, :controller

  import Ecto.Query

  alias Blox.Comment
  alias Blox.Post

  plug :scrub_params, "comment" when action in [:create]
  plug :action

  def create(conn, %{"post_id" => post_id, "comment" => params}) do
    post = Blox.Repo.get(Post, post_id)

    changeset = post
    |> build(:comments)
    |> Comment.changeset(params)

    if changeset.valid? do
      comment = Blox.Repo.insert!(changeset)
      redirect conn, to: post_path(conn, :show, comment.post_id)
    else
      render conn, :new,
        changeset: changeset,
        post_id: post_id
    end
  end

  def delete(conn, %{"post_id" => post_id, "id" => id}) do
    post = Blox.Repo.get(Post, post_id)

    comment = Comment
    |> where([c], c.id == ^id)
    |> where([c], c.post_id == ^post.id)
    |> Blox.Repo.one!

    Blox.Repo.delete!(comment)

    redirect conn, to: post_path(conn, :show, post)
  end
end
