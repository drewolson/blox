defmodule Blox.PostControllerTest do
  use Blox.ControllerTestCase

  alias Blox.Post

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
