defmodule Api.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name",
        password: "some password"
      })
      |> Api.Account.create_user()

    Map.put(user, :password, nil)
  end
end
