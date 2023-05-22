# Api

To start the Phoenix server:

  * `mix deps.get`
  * `mix ecto.migrate`

If it's the first time you're running this, I recommend seeding the database first using the interactive shell

  * `iex -S mix phx.server`
  * `Importer.run("food_trucks_seed.csv")`

Then on subsequent runs the server can just be started with 

  * `mix phx.server`