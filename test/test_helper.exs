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

ExUnit.start
