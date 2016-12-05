defmodule Lottery do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Lottery.Repo, []),
      supervisor(Lottery.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: Lottery.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Lottery.Endpoint.config_change(changed, removed)
    :ok
  end
end
