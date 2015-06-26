defmodule Blox.CommentController do
  use Blox.Web, :controller

  alias Blox.Comment
  alias Blox.Post

  plug :scrub_params, "comment" when action in [:create]
  plug :find_post!
  plug :action

  def create(conn, %{"comment" => params}) do
    post = conn.assigns[:post]
    changeset = post
    |> build(:comments)
    |> Comment.changeset(params)

    if changeset.valid? do
      comment = Blox.Repo.insert!(changeset)
      redirect conn, to: post_path(conn, :show, comment.post_id)
    else
      render conn, :new, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    post = conn.assigns[:post]
    comment = post |> Ecto.Model.assoc(:comments) |> Blox.Repo.get(id)
    Blox.Repo.delete!(comment)

    redirect conn, to: post_path(conn, :show, post)
  end

  def find_post!(conn, _key_values) do
    post = Blox.Repo.get_by(Post, %{"id": Map.get(conn.params, "post_id")})
    case post do
      nil  -> find_post_error!(conn)
      post -> assign(conn, :post, post)
    end
  end

  defp find_post_error!(conn) do
    conn
    |> put_flash(:error, "Post not found")
    |> redirect(to: post_path(conn, :index))
    |> halt
  end
end
