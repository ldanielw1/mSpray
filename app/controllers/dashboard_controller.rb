class DashboardController < ApplicationController
  def view
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

    # Prep all MalariaReport objects for displaying in map view.
    malaria_reports = MalariaReport.all.map do |data|
      attribute_hash = data.attributes
      ["lat", "lng"].each { |label| attribute_hash[label] = attribute_hash[label].to_f }
      attribute_hash
    end

    gon.data = { google_maps_apikey: ENV["GOOGLE_MAPS_APIKEY"], spray_data: spray_data, future_spray_locations: future_spray_locations, malaria_reports: malaria_reports }

    @stat = Stat.new
  end
end
