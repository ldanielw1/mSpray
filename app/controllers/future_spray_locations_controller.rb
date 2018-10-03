require 'csv'

##
# Controller managing data tables for admins
class FutureSprayLocationsController < ApplicationController
  before_action { get_display_settings(:report_date) }

  ##
  # Display all data
  def view
    @sort_hash = get_proper_sort_categories([:reporter, :lat, :lng])
    @locations = FutureSprayLocation.all.order(@sort_hash)
  end

  ##
  # Add data
  def add
    location = FutureSprayLocation.new(report_date: params[:datetime], reporter: params[:reporter], lat: params[:lat], lng: params[:lng])
    location.save!
    redirect_back(fallback_location: root_path)
  end

  ##
  # Edits data
  def edit
    location = FutureSprayLocation.find(get_params[:id])
    location.report_date = get_params[:report_date]
    location.reporter    = get_params[:reporter]
    location.save!
    redirect_back(fallback_location: view_future_spray_locations_path)
  end

  ##
  # Delete one instance of data
  def delete
    location = FutureSprayLocation.find(get_params[:id])
    location.destroy!
    redirect_back(fallback_location: view_future_spray_locations_path)
  end

  ##
  # Get relevant params
  def get_params
    return params[:future_spray_location]
  end

end
