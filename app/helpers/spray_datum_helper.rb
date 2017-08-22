module SprayDatumHelper

  def create_spray_datum(timestamp, sprayer_id, params)
    sd = SprayDatum.where(timestamp: timestamp, sprayer_id: sprayer_id).first_or_initialize
    sd.accuracy =                      params[:accuracy]
    sd.lat =                           params[:lat]
    sd.lon =                           params[:lng]
    sd.homestead_sprayed =             params[:homestead_sprayed]
    sd.ddt_used_1 =                    params[:ddt_used_1]
    sd.ddt_sprayed_rooms_1 =           params[:ddt_sprayed_rooms_1]
    sd.ddt_sprayed_shelters_1 =        params[:ddt_sprayed_shelters_1]
    sd.ddt_refill_1 =                  params[:ddt_refill_1]
    sd.pyrethroid_used_1 =             params[:pyrethroid_used_1]
    sd.pyrethroid_sprayed_rooms_1 =    params[:pyrethroid_sprayed_rooms_1]
    sd.pyrethroid_sprayed_shelters_1 = params[:pyrethroid_sprayed_shelters_1]
    sd.pyrethroid_refill_1 =           params[:pyrethroid_refill_1]
    sd.ddt_used_2 =                    params[:ddt_used_2]
    sd.ddt_sprayed_rooms_2 =           params[:ddt_sprayed_rooms_2]
    sd.ddt_sprayed_shelters_2 =        params[:ddt_sprayed_shelters_1]
    sd.ddt_refill_2 =                  params[:ddt_refill_2]
    sd.pyrethroid_used_2 =             params[:pyrethroid_used_2]
    sd.pyrethroid_sprayed_rooms_2 =    params[:pyrethroid_sprayed_rooms_2]
    sd.pyrethroid_sprayed_shelters_2 = params[:pyrethroid_sprayed_shelters_2]
    sd.pyrethroid_refill_2 =           params[:pyrethroid_refill_2]
    sd.unsprayed_rooms =               params[:unsprayed_rooms]
    sd.unsprayed_shelters =            params[:unsprayed_shelters]
    sd.foreman =                       params[:foreman]

    sd.save
  end
end
