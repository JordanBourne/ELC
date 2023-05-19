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
        password_hash: "some password_hash"
      })
      |> Api.Account.create_user()

    user
  end
end
