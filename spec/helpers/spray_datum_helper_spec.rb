require 'rails_helper'

include SprayDatumHelper

RSpec.describe(SprayDatumHelper, type: :helper) do

  describe 'SprayDatum creation' do
    it 'fails when no input params are provided' do
      begin
        create_spray_datum({})
        raise RuntimeError, "This error should not come up"
      rescue NoMethodError => e
        # Expect it to get here
      end
    end

    it 'works when proper input params are provided' do
      spray_data_count = SprayDatum.count
      create_spray_datum({:timestamp=>"2018-09-06 15:24:55", :imei=>"358240051111110", :lat=>"-23.15287975", :lng=>"29.44401074", :gps_accuracy=>"20", :is_mopup_spray=>"FALSE", :foreman=>"Daniel", :chemical_used=>"K-Orthrine", :unsprayed_rooms=>1, :unsprayed_shelters=>11, :stats=>{"2"=>{:rooms_sprayed=>"22", :shelters_sprayed=>"1", :refilled=>"false"}}})
      new_spray_data_count = SprayDatum.count
      expect(new_spray_data_count).to eql(spray_data_count + 1)
    end
  end

end
