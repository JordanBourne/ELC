defmodule Api.Repo.Migrations.CreateFoodtruckRating do
  use Ecto.Migration

  def change do
    create table(:food_truck_rating) do
      add :rating, :integer
      add :user_id, references(:user, on_delete: :nothing)
      add :food_truck_id, references(:food_truck, on_delete: :nothing)

      timestamps()
    end

    create index(:food_truck_rating, [:user_id])
  end
end
