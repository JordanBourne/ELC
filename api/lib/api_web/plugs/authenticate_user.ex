defmodule ApiWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]

  alias Api.Account.Guardian

  def init(default), do: default

  def call(conn, _default) do
    case Guardian.Plug.current_resource(conn) do
      nil -> unauthorized(conn)
      user -> assign(conn, :current_user, user)
    end
  end

  defp unauthorized(conn) do
    conn
    |> json(%{error: "Unauthorized access"})
    |> put_status(:unauthorized)
    |> halt()
  end
end
