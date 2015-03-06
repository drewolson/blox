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
end
