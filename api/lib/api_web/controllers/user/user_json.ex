defmodule ApiWeb.UserJSON do
  alias Api.Account.User

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      email: user.email,
      name: user.name
    }
  end
end
