module SprayDatumHelper

  def create_spray_datum(params)
    sd = SprayDatum.where(timestamp: params[:timestamp], sprayers: params[:stats].keys.to_yaml).first_or_initialize
    sd.imei                  = params[:imei]
    sd.lat                   = params[:lat]
    sd.lng                   = params[:lng]
    sd.gps_accuracy          = params[:gps_accuracy]
    sd.is_mopup_spray        = params[:is_mopup_spray]
    sd.homestead_sprayed     = params[:homestead_sprayed]
    sd.foreman               = params[:foreman]
    sd.chemical_used         = params[:chemical_used]
    sd.unsprayed_rooms       = params[:unsprayed_rooms]
    sd.unsprayed_shelters    = params[:unsprayed_shelters]
    sd.stats                 = params[:stats]

    sd.save
  end
end
