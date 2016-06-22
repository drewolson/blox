defmodule Blox.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Blox.Post

  schema "comments" do
    field :body, :string

    belongs_to :post, Post

    timestamps
  end

  def changeset(comment, params \\ %{}) do
    comment
    |> cast(params, [:body])
    |> validate_required([:body])
  end
end
