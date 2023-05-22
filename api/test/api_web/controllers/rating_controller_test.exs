defmodule ApiWeb.RatingControllerTest do
  use ApiWeb.ConnCase

  import Api.FoodTrucksFixtures
  import Api.AccountFixtures

  alias Api.{Repo, FoodTrucks.Rating}

  @valid_attrs %{rating: 5}

  describe "index" do
    setup [:create_food_truck, :create_user]

    test "returns unauthenticated when user is not authenticated", %{conn: conn} do
      conn = get(conn, ~p"/api/ratings")
      assert json_response(conn, 401)
    end

    test "lists all ratings for current user", %{conn: conn, user: user, food_truck: food_truck} do
      rating_fixture(%{user_id: user.id, food_truck_id: food_truck.id})

      conn = authenticate_user(conn, user)
      conn = get(conn, ~p"/api/ratings")
      assert %{"data" => [rating_data]} = json_response(conn, 200)
      assert rating_data["food_truck_id"] == food_truck.id
      assert rating_data["food_truck"]["applicant"] == food_truck.applicant
    end
  end

  describe "get" do
    setup [:create_food_truck, :create_user]

    test "returns unauthenticated when user is not authenticated", %{conn: conn} do
      conn = get(conn, ~p"/api/rating?food_truck_id=5")
      assert json_response(conn, 401)
    end

    test "returns a 404 when no rating is found", %{conn: conn, user: user} do
      conn = authenticate_user(conn, user)
      conn = get(conn, ~p"/api/rating?food_truck_id=5123")
      assert json_response(conn, 404)
    end

    test "fetches the food truck rating for authenticated user and specified food_truck", %{conn: conn, user: user, food_truck: food_truck} do
      rating_fixture(%{user_id: user.id, food_truck_id: food_truck.id})

      conn = authenticate_user(conn, user)
      conn = get(conn, ~p"/api/rating?food_truck_id=#{food_truck.id}")
      assert json_response(conn, 200)["data"]
    end
  end

  describe "create rating" do
    setup [:create_food_truck, :create_user]

    test "creates and renders resource when data is valid", %{conn: conn, user: user, food_truck: food_truck} do
      conn = authenticate_user(conn, user)
      conn = post(conn, ~p"/api/ratings", rating: Map.put(@valid_attrs, :food_truck_id, food_truck.id))
      assert %{ "id" => id } = json_response(conn, 201)["data"]

      rating = Repo.get!(Rating, id)
      assert rating.rating == @valid_attrs[:rating]
      assert rating.user_id == user.id
      assert rating.food_truck_id == food_truck.id
    end
  end

  describe "update rating" do
    setup [:create_user, :create_food_truck]

    test "updates rating and renders rating when data is valid", %{conn: conn, user: user, food_truck: food_truck} do
      rating = rating_fixture(%{user_id: user.id, food_truck_id: food_truck.id})

      conn = authenticate_user(conn, user)
      conn = put(conn, ~p"/api/ratings/#{rating.id}", rating: %{rating: 5})
      assert json_response(conn, 200)["data"]
      updated_rating = Repo.get!(Rating, rating.id)
      assert updated_rating.rating == 5
    end

    test "returns 403 Forbidden when user is not owner of rating", %{conn: conn, user: user, food_truck: food_truck} do
      another_user = user_fixture(%{email: "other@email.com"})
      rating = rating_fixture(%{user_id: another_user.id, food_truck_id: food_truck.id})

      conn = authenticate_user(conn, user)
      conn = put(conn, ~p"/api/ratings/#{rating.id}", rating: %{rating: 5})
      assert json_response(conn, 403)
    end
  end

  describe "random rated food truck" do
    setup [:create_food_truck, :create_user]

    test "returns 404 if no truck is rated", %{conn: conn, user: user} do
      conn = authenticate_user(conn, user)
      conn = get(conn, ~p"/api/ratings/random")
      assert json_response(conn, 404)
    end

    test "gets a random rated food truck", %{conn: conn, user: user, food_truck: food_truck} do
      rating_fixture(%{user_id: user.id, food_truck_id: food_truck.id})

      conn = authenticate_user(conn, user)
      conn = get(conn, ~p"/api/ratings/random")
      assert json_response(conn, 200)["data"]
    end

    test "fails with 401 when not authenticated", %{conn: conn} do
      conn = get(conn, ~p"/api/ratings/random")
      assert json_response(conn, 401)
    end
  end

  defp create_food_truck(_) do
    food_truck = food_truck_fixture()
    %{food_truck: food_truck}
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
