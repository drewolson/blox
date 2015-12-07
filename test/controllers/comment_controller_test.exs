defmodule Blox.CommentControllerTest do
  use Blox.ControllerTestCase

  alias Blox.Comment
  alias Blox.Post

  describe "create" do
    it "creates a comment" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!

      post(conn, "/posts/#{post.id}/comments", %{
        "comment": %{
          "body": "Comment body"
        }
      })

      post = Post
      |> preload(:comments)
      |> Blox.Repo.one

      [comment] = post.comments

      assert comment.body == "Comment body"
    end

    it "requires a body" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!

      post(conn, "/posts/#{post.id}/comments", %{
        "comment": %{
          "body": ""
        }
      })

      post = Post
      |> preload(:comments)
      |> Blox.Repo.one

      assert post.comments == []
    end
  end

  it "redirects when no post is found" do
    conn = post(conn, "/posts/-1/comments", %{
      "comment": %{
        "body": ""
      }
    })

    assert redirected_to(conn) == post_path(conn, :index)
    assert get_flash(conn, :error) == "Post not found"
  end

  describe "delete" do
    it "deletes a comment" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!
      comment = %Comment{post_id: post.id, body: "A comment!"} |> Blox.Repo.insert!

      delete(conn, "/posts/#{post.id}/comments/#{comment.id}")

      post = Post |> Post.with_comments |> Blox.Repo.get(post.id)

      assert post.comments == []
    end
  end
end
