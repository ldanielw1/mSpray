class CreateSprayData < ActiveRecord::Migration[5.0]
  def change
    create_table :spray_data do |t|
      t.string :timeStamp,                                :default => ""
      t.decimal :lat, :precision => 13, :scale => 10,     :default => 0.0
      t.decimal :lon, :precision => 13, :scale => 10,     :default => 0.0
      t.integer :accuracy,                                :default => 0
      t.boolean :homesteadSprayed,                        :default => false
      t.string :sprayerID,                                :default => ""
      t.string :sprayer2ID,                               :default => ""
      t.boolean :DDTUsed1,                                :default => false
      t.integer :DDTSprayedRooms1,                        :default => 0
      t.integer :DDTSprayedShelters1,                     :default => 0
      t.boolean :DDTRefill1,                              :default => false
      t.boolean :pyrethroidUsed1,                         :default => false
      t.integer :pyrethroidSprayedRooms1,                 :default => 0
      t.integer :pyrethroidSprayedShelters1,              :default => 0
      t.boolean :pyrethroidRefill1,                       :default => false
      t.boolean :DDTUsed2,                                :default => false
      t.integer :DDTSprayedRooms2,                        :default => 0
      t.integer :DDTSprayedShelters2,                     :default => 0
      t.integer :DDTRefill2,                              :default => 0
      t.boolean :pyrethroidUsed2,                         :default => false
      t.integer :pyrethroidSprayedRooms2,                 :default => 0
      t.integer :pyrethroidSprayedShelters2,              :default => 0
      t.boolean :pyrethroidRefill2,                       :default => false
      t.integer :unsprayedRooms,                          :default => 0
      t.integer :unsprayedShelters,                       :default => 0
      t.string :foreman,                                  :default => ""

      t.timestamps
    end
  end
end
