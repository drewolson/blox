defmodule Blox.Web do
  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      import Blox.Router.Helpers
      import Phoenix.Controller, only: [
        get_flash: 2,
        get_csrf_token: 0
      ]

      use Phoenix.HTML
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      import Blox.Router.Helpers

      import Ecto.Model, only: [build: 2]
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
