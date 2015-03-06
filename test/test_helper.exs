:erlang.system_flag(:backtrace_depth, 1000)

defmodule Blox.TestCase do
  use ExUnit.CaseTemplate

  using(opts) do
    quote do
      use ExSpec, unquote(opts)
    end
  end
end

defmodule Blox.ControllerTestCase do
  use ExUnit.CaseTemplate

  import Plug.Conn

  using(opts) do
    quote do
      use Blox.TestCase, unquote(opts)
      use Plug.Test

      import Blox.ControllerTestCase
    end
  end

  def send_request(conn) do
    conn
    |> put_private(:plug_skip_csrf_protection, true)
    |> Blox.Endpoint.call([])
  end
end

ExUnit.start
