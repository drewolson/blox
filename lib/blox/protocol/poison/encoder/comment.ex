defimpl Poison.Encoder, for: Blox.Comment do
  def encode(comment, options) do
    %{
      id: comment.id,
      body: comment.body
    } |> Poison.Encoder.encode(options)
  end
end
