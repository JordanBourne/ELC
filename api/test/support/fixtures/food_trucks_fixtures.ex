defmodule Api.FoodTrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Api.FoodTrucks` context.
  """

  @doc """
  Generate a food_truck.
  """
  def food_truck_fixture(attrs \\ %{}) do
    {:ok, food_truck} =
      attrs
      |> Enum.into(%{
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
      })
      |> Api.FoodTrucks.create_food_truck()

    food_truck
  end
end
