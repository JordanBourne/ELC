defmodule ApiWeb.GuardianErrorHandler do
  use ApiWeb, :controller
  @behaviour Guardian.Plug.ErrorHandler

  import Plug.Conn

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    body = to_string(type) <> " " <> to_string(reason)

    conn
    |> put_status(:unauthorized)
    |> json(%{error: body})
    |> halt()
  end
end
