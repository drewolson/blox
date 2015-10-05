defmodule Blox.Repo do
  use Ecto.Repo, otp_app: :blox
  use Scrivener, page_size: 10
end
