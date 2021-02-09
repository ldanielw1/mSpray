require 'csv'

##
# Controller managing data tables for admins
class SprayDataController < ApplicationController
  before_action { get_display_settings(:timestamp) }

  ##
  # Display all spray data
  def view
    @sort_hash = get_proper_sort_categories([:sprayers, :lat, :lng])
    @data = SprayDatum.all.order(@sort_hash)
  end

  ##
  # Edits a spray datum
  def edit
    if current_user.admin?
      sd_params = params[:spray_datum]
      spray_datum = SprayDatum.find(sd_params[:id])

      spray_datum.foreman             = sd_params[:foreman]
      spray_datum.is_mopup_spray      = sd_params[:is_mopup_spray] == "1" ? "true" : "false"
      spray_datum.chemical_used       = sd_params[:chemical_used]
      spray_datum.unsprayed_rooms     = sd_params[:unsprayed_rooms].to_i
      spray_datum.unsprayed_shelters  = sd_params[:unsprayed_shelters].to_i

      new_stats_hash = Hash.new
      sd_params[:stats].each do |old_sprayer, stats|
        new_stats_hash[stats[:name]] = Hash.new
        [:rooms_sprayed, :shelters_sprayed].each do |label|
          new_stats_hash[stats[:name]][label] = stats[label]
        end
        new_stats_hash[stats[:name]][:refilled] = "1" ? "true" : "false"
      end
      spray_datum.stats = new_stats_hash
      spray_datum.save!
    else
      flash[:error] = "#{current_user.name} (#{current_user.email}) does not have the privileges to edit spray data"
    end
    redirect_back(fallback_location: view_spray_data_path)
  end

  ##
  # Delete one instance of spray data
  def delete
    if current_user.admin?
      datum = SprayDatum.find(params[:spray_datum][:id])
      datum.destroy!
    else
      flash[:error] = "#{current_user.name} (#{current_user.email}) does not have the privileges to delete spray data"
    end
    redirect_back(fallback_location: view_spray_data_path)
  end

  def add
    if current_user.admin?
      sd_params = params[:spray_data]

      sd_params[:refilled].each do |sprayer, refill|
        params[:stat][:sprayers_attributes][sprayer][:refilled] = refill
      end

      stats_hash = Hash.new

      params[:stat][:sprayers_attributes].each do |old_sprayer, stats|
        if stats[:name] != ""
          stats_hash[stats[:name]] = Hash.new
          [:rooms_sprayed, :shelters_sprayed].each do |label|
            stats_hash[stats[:name]][label] = stats[label]
          end
          stats_hash[stats[:name]][:refilled] = (stats[:refilled] == "1") ? "true" : "false"
        end
      end

      sd_params[:stats] = stats_hash
      sd_params[:is_mopup_spray] = sd_params[:is_mopup_spray] == "on" ? "true" : "false"

      sd = SprayDatum.where(timestamp: sd_params[:dateTime], sprayers: sd_params[:stats].keys.to_yaml).first_or_initialize
      sd.imei                  = sd_params[:imei]
      sd.lat                   = sd_params[:lat]
      sd.lng                   = sd_params[:lng]
      sd.gps_accuracy          = sd_params[:gps_accuracy]
      sd.is_mopup_spray        = sd_params[:is_mopup_spray]
      sd.foreman               = sd_params[:foreman]
      sd.chemical_used         = sd_params[:chemical_used]
      sd.unsprayed_rooms       = sd_params[:unsprayed_rooms]
      sd.unsprayed_shelters    = sd_params[:unsprayed_shelters]
      sd.stats                 = sd_params[:stats]
      sd.save!

    else
      flash[:error] = "#{current_user.name} (#{current_user.email}) does not have the privileges to edit spray data"
    end
    redirect_back(fallback_location: root_path)
  end

  def edit_location
    sd_params = params[:spray_datum]
    datum = SprayDatum.find(sd_params[:id])
    datum.lat = sd_params[:lat]
    datum.lng = sd_params[:lng]
    datum.save!
    redirect_back(fallback_location: root_path)
  end

end
