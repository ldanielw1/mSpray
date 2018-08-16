class InitialSetup < ActiveRecord::Migration[5.0]
  def change

    create_table :workers do |t|
      t.integer  :worker_id
      t.string   :name
      t.boolean  :active

      t.timestamps
    end

    create_table :spray_data do |t|
      t.string  :timestamp,                               :default => ""
      t.decimal :lat, :precision => 13, :scale => 10,    :default => 0.0
      t.decimal :lon, :precision => 13, :scale => 10,    :default => 0.0
      t.integer :gps_accuracy,                           :default => 0
      t.string  :stats
      t.string  :sprayers
      t.string  :foreman,                                 :default => ""
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
