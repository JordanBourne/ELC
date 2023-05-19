defmodule Api.FoodTrucksTest do
  use Api.DataCase

  alias Api.FoodTrucks

  describe "food_truck" do
    alias Api.FoodTrucks.FoodTruck

    import Api.FoodTrucksFixtures

    @invalid_attrs %{x: nil, y: nil, address: nil, applicant: nil, approved: nil, block: nil, blocklot: nil, cnn: nil, dayshours: nil, expiration_date: nil, facility_type: nil, fire_prevention_districs: nil, food_items: nil, latitude: nil, location: nil, locationId: nil, location_description: nil, longitude: nil, lot: nil, neighborhoods: nil, noi_sent: nil, permit: nil, police_districts: nil, prior_permit: nil, received: nil, schedule: nil, status: nil, supervisor_districts: nil, zipcodes: nil}

    test "list_food_truck/0 returns all food_truck" do
      food_truck = food_truck_fixture()
      assert FoodTrucks.list_food_truck() == [food_truck]
    end

    test "get_food_truck!/1 returns the food_truck with given id" do
      food_truck = food_truck_fixture()
      assert FoodTrucks.get_food_truck!(food_truck.id) == food_truck
    end

    test "create_food_truck/1 with valid data creates a food_truck" do
      valid_attrs = %{x: 120.5, y: 120.5, address: "some address", applicant: "some applicant", approved: ~D[2023-05-18], block: "some block", blocklot: "some blocklot", cnn: 42, dayshours: "some dayshours", expiration_date: ~D[2023-05-18], facility_type: "some facility_type", fire_prevention_districs: 42, food_items: "some food_items", latitude: 120.5, location: "some location", locationId: "some locationId", location_description: "some location_description", longitude: 120.5, lot: "some lot", neighborhoods: 42, noi_sent: "some noi_sent", permit: "some permit", police_districts: 42, prior_permit: true, received: "some received", schedule: "some schedule", status: "some status", supervisor_districts: 42, zipcodes: 42}

      assert {:ok, %FoodTruck{} = food_truck} = FoodTrucks.create_food_truck(valid_attrs)
      assert food_truck.x == 120.5
      assert food_truck.y == 120.5
      assert food_truck.address == "some address"
      assert food_truck.applicant == "some applicant"
      assert food_truck.approved == ~D[2023-05-18]
      assert food_truck.block == "some block"
      assert food_truck.blocklot == "some blocklot"
      assert food_truck.cnn == 42
      assert food_truck.dayshours == "some dayshours"
      assert food_truck.expiration_date == ~D[2023-05-18]
      assert food_truck.facility_type == "some facility_type"
      assert food_truck.fire_prevention_districs == 42
      assert food_truck.food_items == "some food_items"
      assert food_truck.latitude == 120.5
      assert food_truck.location == "some location"
      assert food_truck.locationId == "some locationId"
      assert food_truck.location_description == "some location_description"
      assert food_truck.longitude == 120.5
      assert food_truck.lot == "some lot"
      assert food_truck.neighborhoods == 42
      assert food_truck.noi_sent == "some noi_sent"
      assert food_truck.permit == "some permit"
      assert food_truck.police_districts == 42
      assert food_truck.prior_permit == true
      assert food_truck.received == "some received"
      assert food_truck.schedule == "some schedule"
      assert food_truck.status == "some status"
      assert food_truck.supervisor_districts == 42
      assert food_truck.zipcodes == 42
    end

    test "create_food_truck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = FoodTrucks.create_food_truck(@invalid_attrs)
    end

    test "update_food_truck/2 with valid data updates the food_truck" do
      food_truck = food_truck_fixture()
      update_attrs = %{x: 456.7, y: 456.7, address: "some updated address", applicant: "some updated applicant", approved: ~D[2023-05-19], block: "some updated block", blocklot: "some updated blocklot", cnn: 43, dayshours: "some updated dayshours", expiration_date: ~D[2023-05-19], facility_type: "some updated facility_type", fire_prevention_districs: 43, food_items: "some updated food_items", latitude: 456.7, location: "some updated location", locationId: "some updated locationId", location_description: "some updated location_description", longitude: 456.7, lot: "some updated lot", neighborhoods: 43, noi_sent: "some updated noi_sent", permit: "some updated permit", police_districts: 43, prior_permit: false, received: "some updated received", schedule: "some updated schedule", status: "some updated status", supervisor_districts: 43, zipcodes: 43}

      assert {:ok, %FoodTruck{} = food_truck} = FoodTrucks.update_food_truck(food_truck, update_attrs)
      assert food_truck.x == 456.7
      assert food_truck.y == 456.7
      assert food_truck.address == "some updated address"
      assert food_truck.applicant == "some updated applicant"
      assert food_truck.approved == ~D[2023-05-19]
      assert food_truck.block == "some updated block"
      assert food_truck.blocklot == "some updated blocklot"
      assert food_truck.cnn == 43
      assert food_truck.dayshours == "some updated dayshours"
      assert food_truck.expiration_date == ~D[2023-05-19]
      assert food_truck.facility_type == "some updated facility_type"
      assert food_truck.fire_prevention_districs == 43
      assert food_truck.food_items == "some updated food_items"
      assert food_truck.latitude == 456.7
      assert food_truck.location == "some updated location"
      assert food_truck.locationId == "some updated locationId"
      assert food_truck.location_description == "some updated location_description"
      assert food_truck.longitude == 456.7
      assert food_truck.lot == "some updated lot"
      assert food_truck.neighborhoods == 43
      assert food_truck.noi_sent == "some updated noi_sent"
      assert food_truck.permit == "some updated permit"
      assert food_truck.police_districts == 43
      assert food_truck.prior_permit == false
      assert food_truck.received == "some updated received"
      assert food_truck.schedule == "some updated schedule"
      assert food_truck.status == "some updated status"
      assert food_truck.supervisor_districts == 43
      assert food_truck.zipcodes == 43
    end

    test "update_food_truck/2 with invalid data returns error changeset" do
      food_truck = food_truck_fixture()
      assert {:error, %Ecto.Changeset{}} = FoodTrucks.update_food_truck(food_truck, @invalid_attrs)
      assert food_truck == FoodTrucks.get_food_truck!(food_truck.id)
    end

    test "delete_food_truck/1 deletes the food_truck" do
      food_truck = food_truck_fixture()
      assert {:ok, %FoodTruck{}} = FoodTrucks.delete_food_truck(food_truck)
      assert_raise Ecto.NoResultsError, fn -> FoodTrucks.get_food_truck!(food_truck.id) end
    end

    test "change_food_truck/1 returns a food_truck changeset" do
      food_truck = food_truck_fixture()
      assert %Ecto.Changeset{} = FoodTrucks.change_food_truck(food_truck)
    end
  end
end
