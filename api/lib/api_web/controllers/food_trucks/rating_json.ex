defmodule ApiWeb.RatingJSON do
  alias Api.FoodTrucks.Rating
  alias ApiWeb.FoodTruckJSON

  @doc """
  Renders a list of food_truck_ratings
  """
  def index(%{food_truck_ratings: food_truck_ratings}) do
    %{data: for(food_truck_ratings <- food_truck_ratings, do: data(food_truck_ratings))}
  end

  @doc """
  Renders a single food_truck_rating.
  """
  def show(%{food_truck_rating: food_truck_rating}) do
    %{data: data(food_truck_rating)}
  end

  def show(%{food_truck: food_truck}) do
    FoodTruckJSON.show(%{food_truck: food_truck})
  end

  defp data(%Rating{} = rating) do
    %{
      id: rating.id,
      rating: rating.rating,
      user_id: rating.user_id,
      food_truck_id: rating.food_truck_id
    }
  end
end
