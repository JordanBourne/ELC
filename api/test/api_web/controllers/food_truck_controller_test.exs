defmodule ApiWeb.FoodTruckControllerTest do
  use ApiWeb.ConnCase

  import Api.FoodTrucksFixtures

  alias Api.FoodTrucks.FoodTruck

  @create_attrs %{
    address: "some address",
    applicant: "some applicant",
    approved: ~D[2023-05-18],
    block: "some block",
    blocklot: "some blocklot",
    cnn: 42,
    dayshours: "some dayshours",
    expiration_date: ~D[2023-05-18],
    facility_type: "some facility_type",
    fire_prevention_districs: 42,
    food_items: "some food_items",
    latitude: 120.5,
    location: "some location",
    locationId: "some locationId",
    location_description: "some location_description",
    longitude: 120.5,
    lot: "some lot",
    neighborhoods: 42,
    noi_sent: "some noi_sent",
    permit: "some permit",
    police_districts: 42,
    prior_permit: true,
    received: "some received",
    schedule: "some schedule",
    status: "some status",
    supervisor_districts: 42,
    x: 120.5,
    y: 120.5,
    zipcodes: 42
  }
  @update_attrs %{
    address: "some updated address",
    applicant: "some updated applicant",
    approved: ~D[2023-05-19],
    block: "some updated block",
    blocklot: "some updated blocklot",
    cnn: 43,
    dayshours: "some updated dayshours",
    expiration_date: ~D[2023-05-19],
    facility_type: "some updated facility_type",
    fire_prevention_districs: 43,
    food_items: "some updated food_items",
    latitude: 456.7,
    location: "some updated location",
    locationId: "some updated locationId",
    location_description: "some updated location_description",
    longitude: 456.7,
    lot: "some updated lot",
    neighborhoods: 43,
    noi_sent: "some updated noi_sent",
    permit: "some updated permit",
    police_districts: 43,
    prior_permit: false,
    received: "some updated received",
    schedule: "some updated schedule",
    status: "some updated status",
    supervisor_districts: 43,
    x: 456.7,
    y: 456.7,
    zipcodes: 43
  }
  @invalid_attrs %{address: nil, applicant: nil, approved: nil, block: nil, blocklot: nil, cnn: nil, dayshours: nil, expiration_date: nil, facility_type: nil, fire_prevention_districs: nil, food_items: nil, latitude: nil, location: nil, locationId: nil, location_description: nil, longitude: nil, lot: nil, neighborhoods: nil, noi_sent: nil, permit: nil, police_districts: nil, prior_permit: nil, received: nil, schedule: nil, status: nil, supervisor_districts: nil, x: nil, y: nil, zipcodes: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all food_truck", %{conn: conn} do
      conn = get(conn, ~p"/api/food_truck")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create food_truck" do
    test "renders food_truck when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/food_truck", food_truck: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/food_truck/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some address",
               "applicant" => "some applicant",
               "approved" => "2023-05-18",
               "block" => "some block",
               "blocklot" => "some blocklot",
               "cnn" => 42,
               "dayshours" => "some dayshours",
               "expiration_date" => "2023-05-18",
               "facility_type" => "some facility_type",
               "fire_prevention_districs" => 42,
               "food_items" => "some food_items",
               "latitude" => 120.5,
               "location" => "some location",
               "locationId" => "some locationId",
               "location_description" => "some location_description",
               "longitude" => 120.5,
               "lot" => "some lot",
               "neighborhoods" => 42,
               "noi_sent" => "some noi_sent",
               "permit" => "some permit",
               "police_districts" => 42,
               "prior_permit" => true,
               "received" => "some received",
               "schedule" => "some schedule",
               "status" => "some status",
               "supervisor_districts" => 42,
               "x" => 120.5,
               "y" => 120.5,
               "zipcodes" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/food_truck", food_truck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update food_truck" do
    setup [:create_food_truck]

    test "renders food_truck when data is valid", %{conn: conn, food_truck: %FoodTruck{id: id} = food_truck} do
      conn = put(conn, ~p"/api/food_truck/#{food_truck}", food_truck: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/food_truck/#{id}")

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "applicant" => "some updated applicant",
               "approved" => "2023-05-19",
               "block" => "some updated block",
               "blocklot" => "some updated blocklot",
               "cnn" => 43,
               "dayshours" => "some updated dayshours",
               "expiration_date" => "2023-05-19",
               "facility_type" => "some updated facility_type",
               "fire_prevention_districs" => 43,
               "food_items" => "some updated food_items",
               "latitude" => 456.7,
               "location" => "some updated location",
               "locationId" => "some updated locationId",
               "location_description" => "some updated location_description",
               "longitude" => 456.7,
               "lot" => "some updated lot",
               "neighborhoods" => 43,
               "noi_sent" => "some updated noi_sent",
               "permit" => "some updated permit",
               "police_districts" => 43,
               "prior_permit" => false,
               "received" => "some updated received",
               "schedule" => "some updated schedule",
               "status" => "some updated status",
               "supervisor_districts" => 43,
               "x" => 456.7,
               "y" => 456.7,
               "zipcodes" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, food_truck: food_truck} do
      conn = put(conn, ~p"/api/food_truck/#{food_truck}", food_truck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete food_truck" do
    setup [:create_food_truck]

    test "deletes chosen food_truck", %{conn: conn, food_truck: food_truck} do
      conn = delete(conn, ~p"/api/food_truck/#{food_truck}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/food_truck/#{food_truck}")
      end
    end
  end

  defp create_food_truck(_) do
    food_truck = food_truck_fixture()
    %{food_truck: food_truck}
  end
end
