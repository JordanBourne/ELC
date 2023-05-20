defmodule ApiWeb.SessionController do
  use ApiWeb, :controller
  alias Api.Account

  def create(conn, %{"session" => session_params}) do
    case Account.authenticate_user(session_params["email"], session_params["password"]) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Api.Account.Guardian.encode_and_sign(user)
        conn
        |> put_status(:created)
        |> json(%{token: jwt})
      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid email or password"})
    end
  end
end
