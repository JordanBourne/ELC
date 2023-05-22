defmodule ApiWeb.RatingController do
  use ApiWeb, :controller
  alias Api.{FoodTrucks, FoodTrucks.Rating, Account}

  plug ApiWeb.Plugs.AuthenticateUser when action in [:create, :index, :random, :update]

  def index(conn, %{"food_truck_id" => food_truck_id}) do
    current_user = conn.assigns.current_user
    case Account.get_rating_by_food_truck_id_and_user(current_user, food_truck_id) do
      nil ->
        conn
        |> put_status(404)
        |> json(%{"error" => "Rating not found"})
      rating ->
        render(conn, :show, food_truck_rating: rating)
    end
  end

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

  def update(conn, %{"id" => id, "rating" => rating_params}) do
    current_user = conn.assigns.current_user
    rating = FoodTrucks.get_rating!(id)

    if rating.user_id == current_user.id do
      case FoodTrucks.update_rating(rating, rating_params) do
        {:ok, rating} ->
          render(conn, :show, food_truck_rating: rating)
        {:error, _changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{"error" => "Unprocessable Entity"})
      end
    else
      conn
      |> put_status(:forbidden)
      |> json(%{error: "Unauthorized access"})
      |> halt()
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
