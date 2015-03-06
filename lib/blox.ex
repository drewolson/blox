defmodule Blox do
  use Application

  def start(_type, _args) do
    Blox.Supervisor.start_link
  end

  def config_change(changed, _new, removed) do
    Blox.Endpoint.config_change(changed, removed)
    :ok
  end
end
