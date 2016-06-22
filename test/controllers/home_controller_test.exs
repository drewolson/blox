defmodule Blox.HomeControllerTest do
  use Blox.ControllerTestCase

  describe "show" do
    test "renders successfully" do
      conn = get(conn, "/")

      assert conn.status == 200
    end
  end
end
