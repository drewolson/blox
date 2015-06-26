defmodule Blox.CommentController do
  use Blox.Web, :controller

  alias Blox.Comment

  plug :scrub_params, "comment" when action in [:create]
  plug :action

  def create(conn, %{"post_id" => post_id, "comment" => params}) do
    changeset = %Comment{post_id: String.to_integer(post_id)}
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
end
