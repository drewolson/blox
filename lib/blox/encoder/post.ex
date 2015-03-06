defimpl Poison.Encoder, for: Blox.Post do
  def encode(post, _options) do
    %{
      id: post.id,
      title: post.title,
      body: post.body
    } |> Poison.Encoder.encode([])
  end
end
