defmodule Api.Repo.Migrations.CreateFoodTruck do
  use Ecto.Migration

  def change do
    create table(:food_truck) do
      add :locationId, :string
      add :applicant, :string
      add :facility_type, :string
      add :cnn, :integer
      add :location_description, :string
      add :address, :string
      add :blocklot, :string
      add :block, :string
      add :lot, :string
      add :permit, :string
      add :status, :string
      add :food_items, :text
      add :x, :float
      add :y, :float
      add :latitude, :float
      add :longitude, :float
      add :schedule, :string
      add :dayshours, :string
      add :noi_sent, :string
      add :approved, :date
      add :received, :string
      add :prior_permit, :boolean, default: false, null: false
      add :expiration_date, :date
      add :location, :string
      add :fire_prevention_districs, :integer
      add :police_districts, :integer
      add :supervisor_districts, :integer
      add :zipcodes, :integer
      add :neighborhoods, :integer

      timestamps()
    end
  end
end
