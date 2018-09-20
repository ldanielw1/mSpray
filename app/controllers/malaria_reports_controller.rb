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
    spray_location = MalariaReport.new(lat: params[:lat], lng: params[:lng], report_date: params[:dateTime], reporter: params[:reporter])
    spray_location.save!
    redirect_back(fallback_location: dashboard_path)
  end

  ##
  # Edits data
  def edit
    report = MalariaReport.find(get_params[:id])
    report.report_time = get_params[:report_time]
    report.reporter    = get_params[:reporter]
    report.save!
    redirect_back(fallback_location: view_malaria_reports_path)
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
