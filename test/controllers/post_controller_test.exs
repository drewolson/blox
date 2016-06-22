defmodule Blox.PostControllerTest do
  use Blox.ControllerTestCase

  alias Blox.Comment
  alias Blox.Post

  describe "create" do
    test "creates a post" do
      post(conn, "/posts", %{
        "post": %{
          "title": "A title",
          "body": "Post body"
        }
      })

      post = Post |> Blox.Repo.one

      assert post.title == "A title"
      assert post.body == "Post body"
    end

    test "doesn't create a post if the paramters are invalid" do
      post(conn, "/posts", %{
        "post": %{
          "title": "",
          "body": "Post body"
        }
      })

      post = Post |> Blox.Repo.one

      assert post == nil
    end
  end

  describe "delete" do
    test "deletes the provided post" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!

      delete(conn, "/posts/#{post.id}")

      assert Blox.Repo.get(Post, post.id) == nil
    end
  end

  describe "edit" do
    test "renders" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!

      conn = get(conn, "/posts/#{post.id}/edit")

      assert conn.status == 200
    end
  end

  describe "index" do
    test "displays posts" do
      %Post{title: "Post 1", body: "Body 1"} |> Blox.Repo.insert!
      %Post{title: "Post 2", body: "Body 2"} |> Blox.Repo.insert!

      conn = get(conn, "/posts")

      assert String.contains?(conn.resp_body, "Post 1")
      assert String.contains?(conn.resp_body, "Post 2")
    end

    test "renders json" do
      post1 = %Post{title: "Post 1", body: "Body 1"} |> Blox.Repo.insert!
      post2 = %Post{title: "Post 2", body: "Body 2"} |> Blox.Repo.insert!

      conn = get(conn, "/api/v1/posts")
      body = Poison.Parser.parse!(conn.resp_body)

      assert body == [
        %{
          "id" => post1.id,
          "title" => "Post 1",
          "body" => "Body 1",
          "comments" => []
        },
        %{
          "id" => post2.id,
          "title" => "Post 2",
          "body" => "Body 2",
          "comments" => []
        },
      ]
    end
  end

  describe "new" do
    test "renders" do
      conn = get(conn, "/posts/new")

      assert conn.status == 200
    end
  end

  describe "show" do
    test "displays a post and its body" do
      post = %Post{title: "Bob Loblaw", body: "Some lawyer-y stuff goes here"} |> Blox.Repo.insert!

      conn = get(conn, "/posts/#{post.id}")

      assert String.contains?(conn.resp_body, "Bob Loblaw")
      assert String.contains?(conn.resp_body, "Some lawyer-y stuff goes here")
    end

    test "includes comments" do
      post = %Post{title: "Bob Loblaw", body: "Some lawyer-y stuff goes here"} |> Blox.Repo.insert!
      %Comment{post_id: post.id, body: "I have the worst lawyers"} |> Blox.Repo.insert!

      conn = get(conn, "/posts/#{post.id}")

      assert String.contains?(conn.resp_body, "I have the worst lawyers")
    end

    test "renders json with comments" do
      post = %Post{title: "Bob Loblaw", body: "Some lawyer-y stuff goes here"} |> Blox.Repo.insert!
      comment = %Comment{post_id: post.id, body: "I have the worst lawyers"} |> Blox.Repo.insert!

      conn = get(conn, "/api/v1/posts/#{post.id}")

      body = Poison.Parser.parse!(conn.resp_body)

      assert body == %{
        "id" => post.id,
        "title" => "Bob Loblaw",
        "body" => "Some lawyer-y stuff goes here",
        "comments" => [
          %{
            "id" => comment.id,
            "body" => "I have the worst lawyers"
          }
        ]
      }
    end
  end

  describe "update" do
    test "updates the post with the provided values" do
      post = %Post{title: "1", body: "1"} |> Blox.Repo.insert!

      patch(conn, "/posts/#{post.id}", %{
        "post": %{
          "title": "2",
          "body": "2"
        }
      })

      post = Blox.Repo.get(Post, post.id)

      assert post.title == "2"
      assert post.body == "2"
    end

    test "doesn't update on validation errors" do
      post = %Post{title: "1", body: "1"} |> Blox.Repo.insert!

      patch(conn, "/posts/#{post.id}", %{
        "post": %{
          "title": "2",
          "body": ""
        }
      })

      post = Blox.Repo.get(Post, post.id)

      assert post.title == "1"
      assert post.body == "1"
    end
  end
end
