defmodule Blox.PostControllerTest do
  use Blox.ControllerTestCase

  alias Blox.Comment
  alias Blox.Post

  describe "create" do
    it "creates a post" do
      conn(:post, "/posts", %{
        "post": %{
          "title": "A title",
          "body": "Post body"
        }
      }) |> send_request

      post = Post |> Blox.Repo.one

      assert post.title == "A title"
      assert post.body == "Post body"
    end

    it "doesn't create a post if the paramters are invalid" do
      conn(:post, "/posts", %{
        "post": %{
          "title": "",
          "body": "Post body"
        }
      }) |> send_request

      post = Post |> Blox.Repo.one

      assert post == nil
    end
  end

  describe "delete" do
    it "deletes the provided post" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!

      conn(:delete, "/posts/#{post.id}") |> send_request

      assert Blox.Repo.get(Post, post.id) == nil
    end
  end

  describe "edit" do
    it "renders" do
      post = %Post{title: "Title", body: "Body"} |> Blox.Repo.insert!

      conn = conn(:get, "/posts/#{post.id}/edit") |> send_request

      assert conn.status == 200
    end
  end

  describe "index" do
    it "displays posts" do
      %Post{title: "Post 1", body: "Body 1"} |> Blox.Repo.insert!
      %Post{title: "Post 2", body: "Body 2"} |> Blox.Repo.insert!

      conn = conn(:get, "/posts") |> send_request

      assert String.contains?(conn.resp_body, "Post 1")
      assert String.contains?(conn.resp_body, "Post 2")
    end

    it "renders json" do
      post1 = %Post{title: "Post 1", body: "Body 1"} |> Blox.Repo.insert!
      post2 = %Post{title: "Post 2", body: "Body 2"} |> Blox.Repo.insert!

      conn = conn(:get, "/api/v1/posts") |> send_request
      body = Poison.Parser.parse!(conn.resp_body)

      assert body == [
        %{
          "id" => post1.id,
          "title" => "Post 1",
          "body" => "Body 1"
        },
        %{
          "id" => post2.id,
          "title" => "Post 2",
          "body" => "Body 2"
        },
      ]
    end
  end

  describe "new" do
    it "renders" do
      conn = conn(:get, "/posts/new") |> send_request

      assert conn.status == 200
    end
  end

  describe "show" do
    it "displays a post and its body" do
      post = %Post{title: "Bob Loblaw", body: "Some lawyer-y stuff goes here"} |> Blox.Repo.insert!

      conn = conn(:get, "/posts/#{post.id}") |> send_request

      assert String.contains?(conn.resp_body, "Bob Loblaw")
      assert String.contains?(conn.resp_body, "Some lawyer-y stuff goes here")
    end

    it "includes comments" do
      post = %Post{title: "Bob Loblaw", body: "Some lawyer-y stuff goes here"} |> Blox.Repo.insert!
      %Comment{post_id: post.id, body: "I have the worst lawyers"} |> Blox.Repo.insert!

      conn = conn(:get, "/posts/#{post.id}") |> send_request

      assert String.contains?(conn.resp_body, "I have the worst lawyers")
    end

    it "renders json" do
      post = %Post{title: "Bob Loblaw", body: "Some lawyer-y stuff goes here"} |> Blox.Repo.insert!

      conn = conn(:get, "/api/v1/posts/#{post.id}") |> send_request

      body = Poison.Parser.parse!(conn.resp_body)

      assert body == %{
        "id" => post.id,
        "title" => "Bob Loblaw",
        "body" => "Some lawyer-y stuff goes here"
      }
    end
  end

  describe "update" do
    it "updates the post with the provided values" do
      post = %Post{title: "1", body: "1"} |> Blox.Repo.insert!

      conn(:patch, "/posts/#{post.id}", %{
        "post": %{
          "title": "2",
          "body": "2"
        }
      }) |> send_request

      post = Blox.Repo.get(Post, post.id)

      assert post.title == "2"
      assert post.body == "2"
    end

    it "doesn't update on validation errors" do
      post = %Post{title: "1", body: "1"} |> Blox.Repo.insert!

      conn(:patch, "/posts/#{post.id}", %{
        "post": %{
          "title": "2",
          "body": ""
        }
      }) |> send_request

      post = Blox.Repo.get(Post, post.id)

      assert post.title == "1"
      assert post.body == "1"
    end
  end
end
