defmodule Polls do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      {Bandit, plug: Polls.Api.Router, scheme: :http, port: Application.get_env(:polls, :port)},
      Users.Repo
    ]

    opts = [strategy: :one_for_one, name: Polls.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
