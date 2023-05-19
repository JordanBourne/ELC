defmodule Importer do
  alias Api.Repo
  alias Api.FoodTrucks.FoodTruck

  def run(file) do
    file
    |> File.stream!()
    |> CSV.decode(headers: true)
    |> Stream.map(&parse_row/1)
    |> Enum.to_list()
    |> insert_rows()
  end

  defp insert_rows(a) do
    Repo.insert_all(FoodTruck, a)
  end

  defp parse_row({:ok, row}) do
    %{
      "locationid" => location_id,
      "Applicant" => applicant,
      "FacilityType" => facility_type,
      "cnn" => cnn,
      "LocationDescription" => location_description,
      "Address" => address,
      "blocklot" => blocklot,
      "block" => block,
      "lot" => lot,
      "permit" => permit,
      "Status" => status,
      "FoodItems" => food_items,
      "X" => x,
      "Y" => y,
      "Latitude" => latitude,
      "Longitude" => longitude,
      "Schedule" => schedule,
      "dayshours" => dayshours,
      "NOISent" => noi_sent,
      "Approved" => approved,
      "Received" => received,
      "PriorPermit" => prior_permit,
      "ExpirationDate" => expiration_date,
      "Location" => location,
      "Fire Prevention Districts" => fire_prevention_districs,
      "Police Districts" => police_districts,
      "Supervisor Districts" => supervisor_districts,
      "Zip Codes" => zipcodes,
      "Neighborhoods (old)" => neighborhoods
    } = row

    %{
      locationId: location_id,
      applicant: applicant,
      facility_type: facility_type,
      cnn: String.to_integer(cnn),
      location_description: location_description,
      address: address,
      blocklot: blocklot,
      block: block,
      lot: lot,
      permit: permit,
      status: status,
      food_items: food_items,
      x: (if x != "", do: String.to_float(x), else: nil),
      y: (if y != "", do: String.to_float(y), else: nil),
      latitude: (if latitude != "0" && latitude != "", do: String.to_float(latitude), else: nil),
      longitude: (if longitude != "0" && longitude != "", do: String.to_float(longitude), else: nil),
      schedule: schedule,
      dayshours: dayshours,
      noi_sent: noi_sent,
      approved: (if approved != "", do: parse_date(approved), else: nil),
      received: received,
      prior_permit: (if prior_permit == "1", do: true, else: false),
      expiration_date: (if expiration_date != "", do: parse_date(expiration_date), else: nil),
      location: location,
      fire_prevention_districs: (if fire_prevention_districs != "", do: String.to_integer(fire_prevention_districs), else: nil),
      police_districts: (if police_districts != "", do: String.to_integer(police_districts), else: nil),
      supervisor_districts: (if supervisor_districts != "", do: String.to_integer(supervisor_districts), else: nil),
      zipcodes: (if zipcodes != "", do: String.to_integer(zipcodes), else: nil),
      neighborhoods: (if neighborhoods != "", do: String.to_integer(neighborhoods), else: nil),
      inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
      updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
    }
  end

  defp parse_date(date_string) do
    [date_part, _time_part, _am_pm] = String.split(date_string, " ")
    [month, day, year] = String.split(date_part, "/") |> Enum.map(&String.to_integer/1)

    {:ok, date} = Date.new(year, month, day)
    date
  end
end
