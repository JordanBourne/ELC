defmodule ApiWeb.RatingController do
  use ApiWeb, :controller
  alias Api.{FoodTrucks, FoodTrucks.Rating, Account}

  plug ApiWeb.Plugs.AuthenticateUser when action in [:create, :index, :random]

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    ratings = Account.list_ratings_for_user(current_user)
    render(conn, :index, food_truck_ratings: ratings)
  end

  def create(conn, %{"rating" => rating_params}) do
    current_user = conn.assigns.current_user
    food_truck_id = rating_params["food_truck_id"]
    rating_value = rating_params["rating"]

    with {:ok, %Rating{} = rating} <- FoodTrucks.create_rating(%{
      user_id: current_user.id,
      food_truck_id: food_truck_id,
      rating: rating_value
    }) do
      conn
      |> put_status(:created)
      |> render(:show, food_truck_rating: rating)
    end
  end

  def random(conn, _params) do
    current_user = conn.assigns.current_user
    case Account.get_random_rated_food_truck(current_user) do
      {:ok, food_truck} -> render(conn, :show, food_truck: food_truck)
      :error -> conn |> put_status(:not_found) |> json(%{error: "No rated food trucks found"})
    end
  end
end
