class RemoveCountryFromBreweries < ActiveRecord::Migration[6.0]
  def change
    remove_column :breweries, :country, :string
  end
end
