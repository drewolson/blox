defmodule Blox.CommentControllerTest do
  use Blox.ControllerTestCase

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
  end
end
