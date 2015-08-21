defmodule Blox.Post do
  use Ecto.Model

  import Ecto.Query

  alias Blox.Comment

  schema "posts" do
    field :title, :string
    field :body,  :string

    has_many :comments, Comment

    timestamps
  end

  def changeset(post, params \\ :empty) do
    post |> cast(params, ~w(title body))
  end

  def order_by_date(query) do
    query |> order_by([p], desc: p.updated_at)
  end

  def with_comments(query) do
    query |> preload(:comments)
  end
end
