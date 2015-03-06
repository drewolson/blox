defmodule Blox.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Blox do
    pipe_through :browser

    get "/", HomeController, :show

    resources "/posts", PostController
  end

  scope "/api/v1", Blox do
    pipe_through :api

    resources "/posts", PostController, only: [:index, :show]
  end
end
