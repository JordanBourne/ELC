defmodule ApiWeb.SessionControllerTest do
  use ApiWeb.ConnCase, async: true

  alias Api.Account

  setup do
    {:ok, user} = Account.create_user(%{email: "test@example.com", name: "Test", password: "password123"})
    %{user: user}
  end

  test "create session", %{conn: conn, user: user} do
    conn = post(conn, ~p"/api/sessions", session: %{email: user.email, password: "password123"})
    assert %{"token" => _token} = json_response(conn, 201)
  end

  test "fail to create session with invalid data", %{conn: conn} do
    conn = post(conn, ~p"/api/sessions", session: %{email: "wrong@example.com", password: "wrongpassword"})
    assert json_response(conn, 401)
  end
end
