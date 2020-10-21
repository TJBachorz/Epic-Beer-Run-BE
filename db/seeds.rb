# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Brewery.destroy_all
require 'rest-client'
require 'json'

states = [
    "Alaska",
    "Alabama",
    "Arkansas",
    "Arizona",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Iowa",
    "Idaho",
    "Illinois",
    "Indiana",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Massachusetts",
    "Maryland",
    "Maine",
    "Michigan",
    "Minnesota",
    "Missouri",
    "Mississippi",
    "Montana",
    "North Carolina",
    "North Dakota",
    "Nebraska",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "Nevada",
    "New York",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Virginia",
    "Vermont",
    "Washington",
    "Wisconsin",
    "West Virginia",
    "Wyoming"
]

def seed_all_breweries states
    states.each do |state|
        num = 1
        data = RestClient.get("https://api.openbrewerydb.org/breweries?by_state=#{state.split(" ").join("_")}&per_page=50&page=#{num}")
        result = JSON.parse(data)
        if result
            result.each do |brewery|
                if brewery["longitude"] && brewery["country"] == "United States"
                    Brewery.create(
                        name: brewery["name"],
                        city: brewery["city"],
                        state: brewery["state"],
                        longitude: brewery["longitude"],
                        latitude: brewery["latitude"],
                        website_url: brewery["website_url"]
                    )
                end
            end
        end
        num += 1
    end
end

seed_all_breweries(states)
