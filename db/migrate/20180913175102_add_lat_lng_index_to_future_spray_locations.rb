class AddLatLngIndexToFutureSprayLocations < ActiveRecord::Migration[5.0]
  def change
    add_index(:future_spray_locations, [:lat, :lng])
    add_index(:malaria_reports, [:lat, :lng])
  end
end
