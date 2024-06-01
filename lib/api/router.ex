defmodule Polls.Api.Router do
  import Plug.Conn

  alias Polls.Api.Response

  use Plug.Router

  plug(
    Corsica,
    origins: "*",
    allow_methods: :all,
    allow_headers: :all
  )

  plug(:match)
  plug(:dispatch)

  forward("/api/v1", to: Polls.Api.Routes.V1)

  match _ do
    conn
    |> Response.json({:error, 404, nil})
  end
end
