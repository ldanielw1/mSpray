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
  # Delete one instance of spray data
  def delete
    datum = SprayDatum.find(params[:spray_datum][:id])
    datum.destroy!
    redirect_back(fallback_location: view_spray_data_path)
  end

end
