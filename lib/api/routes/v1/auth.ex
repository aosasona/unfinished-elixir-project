defmodule Polls.Api.Routes.V1.Auth do
  use Plug.Router

  alias Polls.Api.Response

  plug(:match)
  plug(:dispatch)

  match _ do
    conn |> Response.json({:error, 404})
  end
end
