class CreateSprayData < ActiveRecord::Migration[5.0]
  def change
    create_table :spray_data do |t|
      t.string :timestamp,                               :default => ""
      t.decimal :lat, :precision => 13, :scale => 10,    :default => 0.0
      t.decimal :lon, :precision => 13, :scale => 10,    :default => 0.0
      t.integer :accuracy,                               :default => 0
      t.boolean :homestead_sprayed,                      :default => false
      t.string  :sprayer_id,                             :default => ""
      t.string  :sprayer_2_id,                           :default => ""
      t.boolean :ddt_used_1,                             :default => false
      t.integer :ddt_sprayed_rooms_1,                    :default => 0
      t.integer :ddt_sprayed_shelters_1,                 :default => 0
      t.boolean :ddt_refill_1,                           :default => false
      t.boolean :pyrethroid_used_1,                      :default => false
      t.integer :pyrethroid_sprayed_rooms_1,             :default => 0
      t.integer :pyrethroid_sprayed_shelters_1,          :default => 0
      t.boolean :pyrethroid_refill_1,                    :default => false
      t.boolean :ddt_used_2,                             :default => false
      t.integer :ddt_sprayed_rooms_2,                    :default => 0
      t.integer :ddt_sprayed_shelters_2,                 :default => 0
      t.integer :ddt_refill_2,                           :default => 0
      t.boolean :pyrethroid_used_2,                      :default => false
      t.integer :pyrethroid_sprayed_rooms_2,             :default => 0
      t.integer :pyrethroid_sprayed_shelters_2,          :default => 0
      t.boolean :pyrethroid_refill_2,                    :default => false
      t.integer :unsprayed_rooms,                        :default => 0
      t.integer :unsprayed_shelters,                     :default => 0
      t.string :foreman,                                 :default => ""

      t.timestamps
    end
  end
end
