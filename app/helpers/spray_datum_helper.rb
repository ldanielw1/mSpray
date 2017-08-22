module SprayDatumHelper

  def create_spray_datum(time_stamp, sprayer_id, params)
    SprayDatum.where(timeStamp: time_stamp, sprayerID: sprayer_id).first_or_initialize do |sd|
      sd.accuracy =                      params[:accuracy]
      sd.lat =                           params[:lat]
      sd.lon =                           params[:lng]
      sd.homesteadSprayed =              params[:homestead_sprayed]
      sd.DDTUsed1 =                      params[:DDT_used_1]
      sd.DDTSprayedRooms1 =              params[:DDT_sprayed_rooms_1]
      sd.DDTSprayedShelters1 =           params[:DDT_sprayed_shelters_1]
      sd.DDTRefill1 =                    params[:DDT_refill_1]
      sd.pyrethroidUsed1 =               params[:pyrethroid_used_1]
      sd.pyrethroidSprayedRooms1 =       params[:pyrethroid_sprayed_rooms_1]
      sd.pyrethroidSprayedShelters1 =    params[:pyrethroid_sprayed_shelters_1]
      sd.pyrethroidRefill1 =             params[:pyrethroid_refill]
      sd.DDTUsed2 =                      params[:DDT_used_2]
      sd.DDTSprayedRooms2 =              params[:DDT_sprayed_rooms_2]
      sd.DDTSprayedShelters2 =           params[:DDT_sprayed_shelters_1]
      sd.DDTRefill2 =                    params[:DDT_refill_2]
      sd.pyrethroidUsed2 =               params[:pyrethroid_used_2]
      sd.pyrethroidSprayedRooms2 =       params[:pyrethroid_sprayed_rooms_2]
      sd.pyrethroidSprayedShelters2 =    params[:pyrethroid_sprayed_shelters_2]
      sd.pyrethroidRefill2 =             params[:pyrethroid_refill_2]
      sd.unsprayedRooms =                params[:unsprayed_rooms]
      sd.unsprayedShelters =             params[:unsprayed_shelters]
      sd.foreman =                       params[:foreman]

      sd.save
    end
  end
end
