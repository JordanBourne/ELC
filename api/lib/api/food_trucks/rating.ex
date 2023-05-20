defmodule Api.FoodTrucks.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_truck_rating" do
    field :rating, :integer
    belongs_to :user, Api.Account.User
    belongs_to :food_truck, Api.FoodTrucks.FoodTruck

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:rating, :user_id, :food_truck_id])
    |> validate_required([:rating, :user_id, :food_truck_id])
    |> assoc_constraint(:user)
    |> assoc_constraint(:food_truck)
  end
end
