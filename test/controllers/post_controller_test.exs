defmodule Blox.PostControllerTest do
  use Blox.ControllerTestCase

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

  describe "index" do
    it "displays posts" do
      %Post{title: "Post 1", body: "Body 1"} |> Blox.Repo.insert
      %Post{title: "Post 2", body: "Body 2"} |> Blox.Repo.insert

      conn = conn(:get, "/posts") |> send_request

      assert String.contains?(conn.resp_body, "Post 1")
      assert String.contains?(conn.resp_body, "Post 2")
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
      post = %Post{title: "Bob Loblaw", body: "Some lawyer-y stuff goes here"} |> Blox.Repo.insert

      conn = conn(:get, "/posts/#{post.id}") |> send_request

      assert String.contains?(conn.resp_body, "Bob Loblaw")
      assert String.contains?(conn.resp_body, "Some lawyer-y stuff goes here")
    end
  end
end
