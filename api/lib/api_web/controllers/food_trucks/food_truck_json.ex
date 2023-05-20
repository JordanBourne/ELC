defmodule ApiWeb.FoodTruckJSON do
  alias Api.FoodTrucks.FoodTruck

  @doc """
  Renders a list of food_truck.
  """
  def index(%{food_truck: food_truck}) do
    %{data: for(food_truck <- food_truck, do: data(food_truck))}
  end

  @doc """
  Renders a single food_truck.
  """
  def show(%{food_truck: food_truck}) do
    %{data: data(food_truck)}
  end

  defp data(%FoodTruck{} = food_truck) do
    %{
      id: food_truck.id,
      locationId: food_truck.locationId,
      applicant: food_truck.applicant,
      facility_type: food_truck.facility_type,
      cnn: food_truck.cnn,
      location_description: food_truck.location_description,
      address: food_truck.address,
      blocklot: food_truck.blocklot,
      block: food_truck.block,
      lot: food_truck.lot,
      permit: food_truck.permit,
      status: food_truck.status,
      food_items: food_truck.food_items,
      x: food_truck.x,
      y: food_truck.y,
      latitude: food_truck.latitude,
      longitude: food_truck.longitude,
      schedule: food_truck.schedule,
      dayshours: food_truck.dayshours,
      noi_sent: food_truck.noi_sent,
      approved: food_truck.approved,
      received: food_truck.received,
      prior_permit: food_truck.prior_permit,
      expiration_date: food_truck.expiration_date,
      location: food_truck.location,
      fire_prevention_districs: food_truck.fire_prevention_districs,
      police_districts: food_truck.police_districts,
      supervisor_districts: food_truck.supervisor_districts,
      zipcodes: food_truck.zipcodes,
      neighborhoods: food_truck.neighborhoods
    }
  end
end
