:erlang.system_flag(:backtrace_depth, 1000)

defmodule Blox.TestCase do
  use ExUnit.CaseTemplate

  using(opts) do
    quote do
      use ExUnit.Case, unquote(opts)
    end
  end

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Blox.Repo)
  end
end

defmodule Blox.ControllerTestCase do
  use ExUnit.CaseTemplate

  using(opts) do
    quote do
      use Blox.TestCase, unquote(opts)
      use Phoenix.ConnTest

      import Blox.Router.Helpers
      import Ecto.Query

      @endpoint Blox.Endpoint
    end
  end
end

Ecto.Adapters.SQL.Sandbox.mode(Blox.Repo, :manual)

ExUnit.start
