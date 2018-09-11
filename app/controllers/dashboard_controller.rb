class DashboardController < ApplicationController
  def show
  	# Prep all SprayDatum objects for displaying in map view.
  	spray_data = SprayDatum.all.map do |data|
      attribute_hash = data.attributes
      ["lat", "lng"].each { |label| attribute_hash[label] = attribute_hash[label].to_f }
      attribute_hash
    end

    # Prep all FutureSprayLocation objects for displaying in map view.
	future_spray_locations = FutureSprayLocation.all.map do |data|
      attribute_hash = data.attributes
      ["lat", "lng"].each { |label| attribute_hash[label] = attribute_hash[label].to_f }
      attribute_hash
    end

    gon.data = { spray_data: spray_data, future_spray_locations: future_spray_locations }
  end

  def add_future_spray_location
  	spray_location = FutureSprayLocation.new(lat: params[:lat], lng: params[:lng], reporter: params[:reporter])
  	spray_location.save!
	redirect_back(fallback_location: dashboard_path)
  end

  def delete_future_spray_location
  end

  def edit_future_spray_location
  end
end
