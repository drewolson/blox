defmodule Mix.Tasks.Db.Populate do
  use Mix.Task

  alias Blox.Post

  def run(_args) do
    %Post{
      title: "Elixir is great",
      body: "Here is a bunch of info about Elixir."
    } |> Blox.Repo.insert!

    %Post{
      title: "Something about containers",
      body: "We should totally contain stuff in other stuff. Immutable infrastructure."
    } |> Blox.Repo.insert!
  end
end
