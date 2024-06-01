defmodule Polls.Api.Response do
  import Plug.Conn

  def redirect(conn, path) do
    conn
    |> put_resp_header("location", path)
    |> send_resp(302, "")
  end

  @spec respond(Plug.Conn.t(), {integer, any}) :: Plug.Conn.t()
  defp respond(conn, {code, body}) when code in 200..299 do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(code, Jason.encode!(%{ok: true, data: body}))
  end

  @spec respond(Plug.Conn.t(), {integer, atom, binary}) :: Plug.Conn.t()
  defp respond(conn, {code, error_code, body}) when code in 400..499 do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(code, Jason.encode!(%{ok: false, error: %{code: error_code, message: body}}))
  end

  @spec json(Plug.Conn.t(), {atom(), any}) :: Plug.Conn.t()
  def json(conn, {:ok, data}) do
    conn |> respond({200, data})
  end

  @spec json(Plug.Conn.t(), {:ok, atom(), any}) :: Plug.Conn.t()
  def json(conn, {:ok, code, data}) do
    conn |> respond({code, data})
  end

  @spec json(Plug.Conn.t(), {:error, integer(), any}) :: Plug.Conn.t()
  def json(conn, {:error, code, data}) do
    {error_code, data} =
      case code do
        400 -> {:bad_request, data || "bad request"}
        401 -> {:unauthorized, "you need to be signed in to access this resource"}
        403 -> {:forbidden, "you do not have permission to access this resource"}
        404 -> {:not_found, "the resource you requested for could not be found"}
        422 -> {:unprocessable_entity, data || "unable to process the request"}
        c when c in 400..499 -> {:client_error, data}
        _ -> {:server_error, "an error occurred"}
      end

    conn
    |> respond({code, error_code, data})
  end

  @spec json(Plug.Conn.t(), {:ok, atom(), any}) :: Plug.Conn.t()
  def json(conn, {:error, code}) do
    conn |> json({:error, code, nil})
  end
end
