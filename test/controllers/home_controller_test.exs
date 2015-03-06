defmodule Blox.HomeControllerTest do
  use Blox.ControllerTestCase

  describe "show" do
    it "renders successfully" do
      conn = conn(:get, "/") |> send_request

      assert conn.status == 200
    end
  end
end
