defmodule Api.FoodTrucks do
  @moduledoc """
  The FoodTrucks context.
  """

  import Ecto.Query, warn: false

  alias Api.Repo
  alias Api.FoodTrucks.FoodTruck
  alias Api.Account.User

  @doc """
  Returns the list of food_truck.

  ## Examples

      iex> list_food_truck()
      [%FoodTruck{}, ...]

  """
  def list_food_truck do
    Repo.all(FoodTruck)
  end

  @doc """
  Gets a single food_truck.

  Raises `Ecto.NoResultsError` if the Food truck does not exist.

  ## Examples

      iex> get_food_truck!(123)
      %FoodTruck{}

      iex> get_food_truck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_truck!(id), do: Repo.get!(FoodTruck, id)

  @doc """
  Creates a food_truck.

  ## Examples

      iex> create_food_truck(%{field: value})
      {:ok, %FoodTruck{}}

      iex> create_food_truck(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_truck(attrs \\ %{}) do
    %FoodTruck{}
    |> FoodTruck.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_truck.

  ## Examples

      iex> update_food_truck(food_truck, %{field: new_value})
      {:ok, %FoodTruck{}}

      iex> update_food_truck(food_truck, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_truck(%FoodTruck{} = food_truck, attrs) do
    food_truck
    |> FoodTruck.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_truck.

  ## Examples

      iex> delete_food_truck(food_truck)
      {:ok, %FoodTruck{}}

      iex> delete_food_truck(food_truck)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_truck(%FoodTruck{} = food_truck) do
    Repo.delete(food_truck)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_truck changes.

  ## Examples

      iex> change_food_truck(food_truck)
      %Ecto.Changeset{data: %FoodTruck{}}

  """
  def change_food_truck(%FoodTruck{} = food_truck, attrs \\ %{}) do
    FoodTruck.changeset(food_truck, attrs)
  end

  alias Api.FoodTrucks.Rating

  @doc """
  Returns the list of food_truck_rating.

  ## Examples

      iex> list_food_truck_rating()
      [%Rating{}, ...]

  """
  def list_food_truck_rating do
    Repo.all(Rating)
  end

  @doc """
  Gets a single rating.

  Raises `Ecto.NoResultsError` if the Rating does not exist.

  ## Examples

      iex> get_rating!(123)
      %Rating{}

      iex> get_rating!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rating!(id), do: Repo.get!(Rating, id)

  @doc """
  Creates a rating.

  ## Examples

      iex> create_rating(user_id, food_truck_id, rating_value)
      {:ok, %Rating{}}

      iex> create_rating(bad_user_id, bad_food_truck_id, rating_value)
      {:error, %Ecto.Changeset{}}

  """
  def create_rating(%{user_id: user_id, food_truck_id: food_truck_id, rating: rating_value}) do
    %Rating{}
    |> Rating.changeset(%{user_id: user_id, food_truck_id: food_truck_id, rating: rating_value})
    |> Repo.insert()
  end

  @doc """
  Updates a rating.

  ## Examples

      iex> update_rating(rating, %{field: new_value})
      {:ok, %Rating{}}

      iex> update_rating(rating, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rating(%Rating{} = rating, attrs) do
    rating
    |> Rating.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rating.

  ## Examples

      iex> delete_rating(rating)
      {:ok, %Rating{}}

      iex> delete_rating(rating)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rating(%Rating{} = rating) do
    Repo.delete(rating)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rating changes.

  ## Examples

      iex> change_rating(rating)
      %Ecto.Changeset{data: %Rating{}}

  """
  def change_rating(%Rating{} = rating, attrs \\ %{}) do
    Rating.changeset(rating, attrs)
  end

  def get_random_unrated_food_truck(%User{} = user) do
    rated_food_truck_ids = user
    |> Ecto.assoc(:ratings)
    |> Repo.all()
    |> Enum.map(& &1.food_truck_id)

    query = from f in FoodTruck,
      where: f.id not in ^rated_food_truck_ids,
      order_by: fragment("RANDOM()"),
      limit: 1

    case Repo.one(query) do
      nil -> :error
      food_truck -> {:ok, food_truck}
    end
  end
end
