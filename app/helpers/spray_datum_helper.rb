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
    sd.stats                 = params[:stats]
    sd.save!
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end

    link_to(name, "#", class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})

  end

end
