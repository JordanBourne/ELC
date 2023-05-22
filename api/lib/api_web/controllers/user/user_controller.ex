defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Account
  alias Api.Account.User

  action_fallback ApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      {:ok, jwt, _full_claims} = Api.Account.Guardian.encode_and_sign(user)
        conn
        |> put_status(:created)
        |> json(%{token: jwt})
    end
  end
end
