class CreateMalariaReports < ActiveRecord::Migration[5.0]
  def change
    create_table :malaria_reports do |t|
      t.decimal :lat, :precision => 13, :scale => 10,   :default => 0.0
      t.decimal :lng, :precision => 13, :scale => 10,   :default => 0.0
      t.datetime :report_time,          :default => ""
      t.string :reporter,								:default => ""
    end
  end
end
