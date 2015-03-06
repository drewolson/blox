defmodule Blox.Web do
  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      import Blox.Router.Helpers
      import Blox.Form, only: [
        form_errors: 1,
        form_value: 2
      ]

      use Phoenix.HTML
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      import Blox.Router.Helpers
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
