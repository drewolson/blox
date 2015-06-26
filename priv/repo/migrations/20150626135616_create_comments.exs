defmodule Blox.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :post_id, :integer
      add :body,  :text

      timestamps
    end
  end
end
