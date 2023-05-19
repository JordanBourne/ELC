defmodule Api.FoodTrucks.FoodTruck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_truck" do
    field :address, :string
    field :applicant, :string
    field :approved, :date
    field :block, :string
    field :blocklot, :string
    field :cnn, :integer
    field :dayshours, :string
    field :expiration_date, :date
    field :facility_type, :string
    field :fire_prevention_districs, :integer
    field :food_items, :string
    field :latitude, :float
    field :location, :string
    field :locationId, :string
    field :location_description, :string
    field :longitude, :float
    field :lot, :string
    field :neighborhoods, :integer
    field :noi_sent, :string
    field :permit, :string
    field :police_districts, :integer
    field :prior_permit, :boolean, default: false
    field :received, :string
    field :schedule, :string
    field :status, :string
    field :supervisor_districts, :integer
    field :x, :float
    field :y, :float
    field :zipcodes, :integer

    timestamps()
  end

  @doc false
  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, [:locationId, :applicant, :facility_type, :cnn, :location_description, :address, :blocklot, :block, :lot, :permit, :status, :food_items, :x, :y, :latitude, :longitude, :schedule, :dayshours, :noi_sent, :approved, :received, :prior_permit, :expiration_date, :location, :fire_prevention_districs, :police_districts, :supervisor_districts, :zipcodes, :neighborhoods])
    |> validate_required([:locationId, :applicant, :facility_type, :cnn, :location_description, :address, :blocklot, :block, :lot, :permit, :status, :food_items, :x, :y, :latitude, :longitude, :schedule, :dayshours, :noi_sent, :approved, :received, :prior_permit, :expiration_date, :location, :fire_prevention_districs, :police_districts, :supervisor_districts, :zipcodes, :neighborhoods])
  end
end
