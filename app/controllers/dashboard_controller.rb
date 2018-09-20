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

    # Prep all MalariaReport objects for displaying in map view.
    malaria_reports = MalariaReport.all.map do |data|
      attribute_hash = data.attributes
      ["lat", "lng"].each { |label| attribute_hash[label] = attribute_hash[label].to_f }
      attribute_hash
    end

    gon.data = { spray_data: spray_data, future_spray_locations: future_spray_locations, malaria_reports: malaria_reports }
  end

  def add_future_spray_location
    spray_location = FutureSprayLocation.new(lat: params[:lat], lng: params[:lng], report_time: params[:dateTime], reporter: params[:reporter])
    spray_location.save!
    redirect_back(fallback_location: dashboard_path)
  end

  def delete_future_spray_location
  end

  def edit_future_spray_location
  end

  def add_malaria_report
    spray_location = MalariaReport.new(lat: params[:lat], lng: params[:lng], report_time: params[:dateTime], reporter: params[:reporter])
    spray_location.save!
    redirect_back(fallback_location: dashboard_path)
  end

  def delete_malaria_report
  end

  def edit_malaria_report
  end

end
