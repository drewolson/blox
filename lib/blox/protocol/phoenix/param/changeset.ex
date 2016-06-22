defimpl Phoenix.Param, for: Ecto.Changeset do
  def to_param(changeset) do
    Phoenix.Param.to_param(changeset.data)
  end
end
