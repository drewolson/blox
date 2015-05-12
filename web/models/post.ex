defmodule Blox.Post do
  use Ecto.Model

  import Ecto.Query

  schema "posts" do
    field :title, :string
    field :body,  :string

    timestamps
  end

  def changeset(post, params \\ :empty) do
    post
    |> cast(params, ~w(title body))
  end

  def order_by_date(query) do
    query |> order_by([p], desc: p.updated_at)
  end
end
