class InitialSetup < ActiveRecord::Migration[5.0]
  def change

    create_table :workers do |t|
      t.integer  :worker_id
      t.string   :name
      t.boolean  :active

      t.timestamps
    end

    create_table :spray_data do |t|
      t.string  :imei,                                   :default => ""
      t.string  :timestamp,                              :default => ""
      t.decimal :lat, :precision => 13, :scale => 10,    :default => 0.0
      t.decimal :lng, :precision => 13, :scale => 10,    :default => 0.0
      t.integer :gps_accuracy,                           :default => 0

      t.boolean :is_mopup_spray,                         :default => false

      t.string  :foreman,                                :default => ""
      t.string  :sprayers
      t.string  :chemical_used,                          :default => ""

      t.integer :unsprayed_rooms,                        :default => 0
      t.integer :unsprayed_shelters,                     :default => 0
      t.string  :stats
    end

    create_table :users do |t|
      t.string  :provider
      t.string  :uid
      t.string  :name
      t.string  :email
      t.string  :profile_img
      t.boolean :admin,         default: false
    end

    create_table :allowed_emails do |t|
      t.string :email
    end

  end
end
