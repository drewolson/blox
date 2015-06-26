defmodule Blox.CommentControllerTest do
  use Blox.ControllerTestCase

  alias Blox.Comment
  alias Blox.Post

  describe "create" do
    it "creates a comment" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!

      conn(:post, "/posts/#{post.id}/comments", %{
        "comment": %{
          "body": "Comment body"
        }
      }) |> send_request

      post = Post
      |> preload(:comments)
      |> Blox.Repo.one

      [comment] = post.comments

      assert comment.body == "Comment body"
    end

    it "requires a body" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!

      conn(:post, "/posts/#{post.id}/comments", %{
        "comment": %{
          "body": ""
        }
      }) |> send_request

      post = Post
      |> preload(:comments)
      |> Blox.Repo.one

      assert post.comments == []
    end
  end

  it "redirects when no post is found" do
    conn = conn(:post, "/posts/-1/comments", %{
      "comment": %{
        "body": ""
      }
    }) |> send_request
    assert redirected_to(conn) == post_path(conn, :index)
    assert get_flash(conn, :error) == "Post not found"
  end

  describe "delete" do
    it "deletes a comment" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!
      comment = %Comment{post_id: post.id, body: "A comment!"} |> Blox.Repo.insert!

      conn(:delete, "/posts/#{post.id}/comments/#{comment.id}") |> send_request

      post = Post.find(post.id) |> Blox.Repo.one!

      assert post.comments == []
    end
  end
end
