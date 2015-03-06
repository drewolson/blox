defmodule Blox.Post do
  use Ecto.Model

  schema "posts" do
    field :title, :string
    field :body,  :string

    timestamps
  end

  def changeset(post, params \\ nil) do
    post
    |> cast(params, ~w(title body))
  end

  def order_by_date(query) do
    query |> order_by([p], desc: p.updated_at)
  end
end
