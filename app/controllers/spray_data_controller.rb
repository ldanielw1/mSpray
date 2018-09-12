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
    sd_params = params[:spray_datum]
    spray_datum = SprayDatum.find(sd_params[:id])

    spray_datum.foreman             = sd_params[:foreman]
    spray_datum.is_mopup_spray      = sd_params[:is_mopup_spray]
    spray_datum.chemical_used       = sd_params[:chemical_used]
    spray_datum.unsprayed_rooms     = sd_params[:unsprayed_rooms].to_i
    spray_datum.unsprayed_shelters  = sd_params[:unsprayed_shelters].to_i

    new_stats_hash = Hash.new
    sd_params[:stats].each do |old_sprayer, stats|
      new_stats_hash[stats[:name]] = Hash.new
      [:rooms_sprayed, :shelters_sprayed].each do |label|
        new_stats_hash[stats[:name]][label] = stats[label]
      end
      new_stats_hash[stats[:name]][:refilled] = stats[:refilled].to_i == 1
    end
    spray_datum.stats = new_stats_hash
    spray_datum.save!

    redirect_back(fallback_location: view_spray_data_path)
    
  end

  ##
  # Delete one instance of spray data
  def delete
    datum = SprayDatum.find(params[:spray_datum][:id])
    datum.destroy!
    redirect_back(fallback_location: view_spray_data_path)
  end

end
