# Takehome

## Overview

The goal of this project is to allow you to track which food trucks you have already been to, what your rating was for them, and to include a random discovery of new locations or a suggestion for one you have previously enjoyed.

## Process

### Initial Setup

Starting out the project my first step is to create a simple REST API using Elixir/Phoenix boilerplate to provide the scaffolding for the project moving forward. This is accomplished by using the following generators:

`mix phx.new api --no-assets --no-html`

I'm using `--no-assets` and `--no-html` since this is purely an API and these other dependencies are unnecessary.

Next we will want to generate the DB schemas for the food trucks, as well as the corresponding JSON REST API and basic CRUD operations

```
mix phx.gen.json FoodTrucks FoodTruck food_truck locationId:string applicant:string facility_type:string cnn:integer location_description:string address:string blocklot:string block:string lot:string permit:string status:string food_items:text x:float y:float latitude:float longitude:float schedule:string dayshours:string noi_sent:string approved:date received:string prior_permit:boolean expiration_date:date location:string fire_prevention_districs:integer police_districts:integer supervisor_districts:integer zipcodes:integer neighborhoods:integer
```

Once the schema has been created and migration run, we will want to seed the database from the provided CSV. To do this, I've created a `importer.exs` file to parse the csv and map the existing headers to the defined columns in the CSV. With that created, we can run the following from the interactive Elixir shell:

`Importer.run("food_trucks_seed.csv")`

At this point it's possible to run the server and do all of the CRUD operations on the list of food trucks.

### User Experience

Providing a list of food trucks isn't much of a user experience, so we'll want to build on that by allow users to create accounts and keep track of which food trucks they've visited and the corresponding rating.

The first step will be to create the Accounts and users context and schema.

`mix phx.gen.context Account User user email:string password_hash:string name:string`

As well as the schema for the user's food truck ratings

`mix phx.gen.context FoodTrucks Rating food_truck_rating user_id:references:user food_truck_id:references:food_truck rating:integer`

Next, I've included Guardian to handle token-based authentication for our API, created a Guardian configuration file, defined a Guardian "serializer" module to handle encoding and decoding of JWT tokens, and a custom Guardian pipeline to process authentication-related requests.

In order to register a user or to log in, two endpoints were added to the API. When a user registers or logs in successfully, the server responds with a JWT. This token can then be included in the `Authorization` header for subsequent requests to identify and authenticate the user. 

Using the new authentication logic, I created new routes for the `food_truck_rating` for an authenticated user to rate food trucks they have been to, as well as view a full list of which ones they have rated. These routes require passing in the Authorization header, which it uses to grab the user id and fetch the specified user's ratings.

The last piece of the API was to add the functionality for the random discovery of either unrated food trucks for a new experience, or a random suggested of previously rated food trucks for a random repeat expereince. I've created a new `:random` method in both the food_truck and rating routes and controllers to handle these respectively.

With all of this in place and the tests to verify the functionality, the API portion is complete and the next step is to build out the corresponding UI.

