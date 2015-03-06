defmodule Blox.Form do
  defstruct [:changeset]

  alias Blox.Form

  def new(changeset) do
    %Form{changeset: changeset}
  end

  def form_errors(%Form{changeset: changeset}) do
    changeset.errors
  end

  def form_value(%Form{changeset: changeset}, name) do
    Ecto.Changeset.get_field(changeset, name)
  end
end
