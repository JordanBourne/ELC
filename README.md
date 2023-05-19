Takehome assignment for ELC

Process

Starting out the project my first step is to create a simple REST API using Elixir/Phoenix boilerplate to provide the scaffolding for the project moving forward. This is accomplished by using the following generators:

`mix phx.new api --no-assets --no-html`

I'm using `--no-assets` and `--no-html` since this is purely an API and these other dependencies are unnecessary.

Next we will want to generate the DB schemas for the food trucks, as well as the corresponding JSON REST API and basic CRUD operations

`mix phx.gen.json FoodTrucks FoodTruck food_truck locationId:string applicant:string facility_type:string cnn:integer location_description:string address:string blocklot:string block:string lot:string permit:string status:string food_items:text x:float y:float latitude:float longitude:float schedule:string dayshours:string noi_sent:string approved:date received:string prior_permit:boolean expiration_date:date location:string fire_prevention_districs:integer police_districts:integer supervisor_districts:integer zipcodes:integer neighborhoods:integer`

Once the schema has been created and migration run, we will want to seed the database from the provided CSV. To do this, I've created a `importer.exs` file to parse the csv and map the existing headers to the defined columns in the CSV. With that created, we can run the following from the interactive Elixir shell:

`Importer.run("food_trucks_seed.csv")`
