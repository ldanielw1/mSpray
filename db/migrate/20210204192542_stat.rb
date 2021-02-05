class Stat < ActiveRecord::Migration[6.0]
  def change
    create_table :stats do |t|
      t.string   :sprayers
    end
    create_table :sprayers do |t|
      t.string   :stat_id
      t.string	 :refilled
    end
  end
end
