require 'csv'

##
# Controller managing data tables for admins
class MalariaReportsController < ApplicationController
  before_action { get_display_settings(:report_date) }

  ##
  # Display all data
  def view
    @sort_hash = get_proper_sort_categories([:reporter, :lat, :lng])
    @reports = MalariaReport.all.order(@sort_hash)
  end

  ##
  # Add data
  def add
    report = MalariaReport.new(report_date: get_params[:dateTime], reporter: get_params[:reporter], lat: get_params[:lat], lng: get_params[:lng])
    report.save!
    redirect_back(fallback_location: root_path)
  end

  ##
  # Edits data
  def edit
    report = MalariaReport.find(get_params[:id])
    report.report_date = get_params[:report_date]
    report.reporter    = get_params[:reporter]
    report.save!
    redirect_back(fallback_location: view_malaria_reports_path)
  end

  ##
  # Edits data lat and lng
  def edit_location
    report = MalariaReport.find(get_params[:id])
    report.lat = get_params[:lat]
    report.lng = get_params[:lng]
    report.save!
    redirect_back(fallback_location: root_path)
  end

  ##
  # Delete one instance of data
  def delete
    report = MalariaReport.find(get_params[:id])
    report.destroy!
    redirect_back(fallback_location: view_malaria_reports_path)
  end

  ##
  # Get relevant params
  def get_params
    return params[:malaria_report]
  end

end
