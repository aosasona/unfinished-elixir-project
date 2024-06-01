defmodule Polls.Api.Routes.V1 do
  import Plug.Conn

  alias Polls.Api.Response

  use Plug.Router

  plug(:match)
  plug(:dispatch)

  forward("/auth", to: Polls.Api.Routes.V1.Auth)

  get "/health" do
    conn |> Response.json({:ok, "I am alive!"})
  end

  match _ do
    conn |> Response.json({:error, 404})
  end
end
