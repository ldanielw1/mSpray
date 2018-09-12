module SprayDatumHelper

  def create_spray_datum(params)
    sd = SprayDatum.where(timestamp: params[:timestamp], sprayers: params[:stats].keys.to_yaml).first_or_initialize
    sd.imei                  = params[:imei]
    sd.lat                   = params[:lat]
    sd.lng                   = params[:lng]
    sd.gps_accuracy          = params[:gps_accuracy]
    sd.is_mopup_spray        = params[:is_mopup_spray]
    sd.foreman               = params[:foreman]
    sd.chemical_used         = params[:chemical_used]
    sd.unsprayed_rooms       = params[:unsprayed_rooms]
    sd.unsprayed_shelters    = params[:unsprayed_shelters]

    stats = Hash.new
    params[:stats].each do |sprayer, s_stats|
      stats[sprayer] = Hash.new
      stats[sprayer][:rooms_sprayed] = s_stats["roomsSprayed"]
      stats[sprayer][:shelters_sprayed] = s_stats["sheltersSprayed"]
      stats[sprayer][:refilled] = s_stats["refilled"]
    end
    sd.stats = stats
    sd.save

  end
end
