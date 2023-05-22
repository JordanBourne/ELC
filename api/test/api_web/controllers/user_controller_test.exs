defmodule ApiWeb.UserControllerTest do
  use ApiWeb.ConnCase, async: true

  alias Api.Account

  @create_attrs %{email: "test@example.com", name: "Test", password: "password123"}
  @invalid_attrs %{email: nil, name: nil, password: nil}

  test "create user", %{conn: conn} do
    conn = post(conn, ~p"/api/user", user: @create_attrs)
    assert %{"token" => _jwt_response} = json_response(conn, 201)

    user = Account.get_user_by_email(@create_attrs.email)
    assert user.email == @create_attrs[:email]
  end

  test "fail to create user with invalid data", %{conn: conn} do
    conn = post(conn, ~p"/api/user", user: @invalid_attrs)
    assert json_response(conn, 422)
  end
end
