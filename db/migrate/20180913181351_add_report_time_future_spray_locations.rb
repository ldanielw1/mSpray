class AddReportTimeFutureSprayLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :future_spray_locations, :report_time, :string, :default => ""
  end
end
