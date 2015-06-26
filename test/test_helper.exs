:erlang.system_flag(:backtrace_depth, 1000)

defmodule Blox.TestCase do
  use ExUnit.CaseTemplate

  using(opts) do
    quote do
      use ExSpec, unquote(opts)
    end
  end

  setup do
    Ecto.Adapters.SQL.begin_test_transaction(Blox.Repo)

    ExUnit.Callbacks.on_exit(fn ->
      Ecto.Adapters.SQL.rollback_test_transaction(Blox.Repo)
    end)
  end
end

defmodule Blox.ControllerTestCase do
  use ExUnit.CaseTemplate

  import Plug.Conn

  using(opts) do
    quote do
      use Blox.TestCase, unquote(opts)
      use Phoenix.ConnTest

      import Blox.ControllerTestCase
      import Ecto.Query

      # Import URL helpers from the router
      import Blox.Router.Helpers
    end
  end

  def send_request(conn) do
    conn
    |> put_private(:plug_skip_csrf_protection, true)
    |> Blox.Endpoint.call([])
  end
end

ExUnit.start
