defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  alias Api.Account
  alias Api.Account.User

  action_fallback ApiWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end
end
