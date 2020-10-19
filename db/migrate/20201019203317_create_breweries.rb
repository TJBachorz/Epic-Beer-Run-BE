class CreateBreweries < ActiveRecord::Migration[6.0]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.string :longitude
      t.string :latitude
      t.string :website_url

      t.timestamps
    end
  end
end
