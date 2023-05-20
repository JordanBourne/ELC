defmodule ApiWeb.FoodTruckController do
  use ApiWeb, :controller

  alias Api.FoodTrucks
  alias Api.FoodTrucks.FoodTruck

  action_fallback ApiWeb.FallbackController

  plug ApiWeb.Plugs.AuthenticateUser when action in [:random]

  def index(conn, _params) do
    food_truck = FoodTrucks.list_food_truck()
    render(conn, :index, food_truck: food_truck)
  end

  def create(conn, %{"food_truck" => food_truck_params}) do
    with {:ok, %FoodTruck{} = food_truck} <- FoodTrucks.create_food_truck(food_truck_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/food_truck/#{food_truck.id}")
      |> render(:show, food_truck: food_truck)
    end
  end

  def show(conn, %{"id" => id}) do
    food_truck = FoodTrucks.get_food_truck!(id)
    render(conn, :show, food_truck: food_truck)
  end

  def update(conn, %{"id" => id, "food_truck" => food_truck_params}) do
    food_truck = FoodTrucks.get_food_truck!(id)

    with {:ok, %FoodTruck{} = food_truck} <- FoodTrucks.update_food_truck(food_truck, food_truck_params) do
      render(conn, :show, food_truck: food_truck)
    end
  end

  def delete(conn, %{"id" => id}) do
    food_truck = FoodTrucks.get_food_truck!(id)

    with {:ok, %FoodTruck{}} <- FoodTrucks.delete_food_truck(food_truck) do
      send_resp(conn, :no_content, "")
    end
  end

  def random(conn, _params) do
    current_user = conn.assigns.current_user
    case FoodTrucks.get_random_unrated_food_truck(current_user) do
      {:ok, food_truck} -> render(conn, :show, food_truck: food_truck)
      :error -> conn |> put_status(:not_found) |> json(%{error: "No unrated food trucks found"})
    end
  end
end
