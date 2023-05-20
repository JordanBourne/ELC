defmodule Api.Account do
  @moduledoc """
  The Account context.
  """

  import Ecto.Query, warn: false
  alias Api.Repo

  alias Api.Account.User
  alias Api.FoodTrucks
  alias Api.FoodTrucks.Rating

  @doc """
  Returns the list of user.

  ## Examples

      iex> list_user()
      [%User{}, ...]

  """
  def list_user do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def get_user_by_email(email) when is_binary(email) do
    Repo.get_by(User, email: email)
  end

  def authenticate_user(email, plain_text_password) do
    user = get_user_by_email(email)
    case user do
      nil -> {:error, :invalid_credentials}
      _user ->
        if Bcrypt.verify_pass(plain_text_password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def list_ratings_for_user(%User{} = user) do
    Repo.all(from r in Rating, where: r.user_id == ^user.id, preload: :food_truck)
  end

  def get_random_rated_food_truck(user) do
    query = from r in Ecto.assoc(user, :ratings),
      order_by: fragment("RANDOM()"),
      limit: 1

    case Repo.one(query) do
      nil -> :error
      rating -> {:ok, FoodTrucks.get_food_truck!(rating.food_truck_id)}
    end
  end
end
