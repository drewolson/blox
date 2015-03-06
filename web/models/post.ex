defmodule Blox.Post do
  use Ecto.Model

  schema "posts" do
    field :title, :string
    field :body,  :string

    timestamps
  end
end
