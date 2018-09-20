class InitialSetup < ActiveRecord::Migration[5.0]
  def change

    create_table :workers do |t|
      t.string   :worker_id,                       :default => ""
      t.string   :name,                            :default => ""
      t.boolean  :active,                          :default => true
    end

    create_table :spray_data do |t|
      t.string   :timestamp,                       :default => ""
      t.string   :imei,                            :default => ""

      t.string   :foreman,                         :default => ""
      t.string   :sprayers
      t.string   :chemical_used,                   :default => ""
      t.string   :stats
      t.integer  :unsprayed_rooms,                 :default => 0
      t.integer  :unsprayed_shelters,              :default => 0

      t.boolean  :is_mopup_spray,                  :default => false

      t.float    :lat,                             :default => 0.0
      t.float    :lng,                             :default => 0.0
      t.integer  :gps_accuracy,                    :default => 0
    end

    create_table :malaria_reports do |t|
      t.string   :report_date,                     :default => ""
      t.string   :reporter,                        :default => ""
      t.float    :lat,                             :default => 0.0
      t.float    :lng,                             :default => 0.0
    end

    create_table :future_spray_locations do |t|
      t.string   :report_date,                     :default => ""
      t.string   :reporter,                        :default => ""
      t.float    :lat,                             :default => 0.0
      t.float    :lng,                             :default => 0.0
    end

    create_table :users do |t|
      t.string   :name,                            :default => ""
      t.string   :email,                           :default => ""
      t.string   :profile_img,                     :default => ""
      t.boolean  :admin,                           :default => false

      t.string   :provider,                        :default => ""
      t.string   :uid,                             :default => ""
    end

    create_table :allowed_emails do |t|
      t.string   :email,                           :default => ""
    end

  end
end
