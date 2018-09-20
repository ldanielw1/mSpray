require 'csv'

##
# Controller managing data tables for admins
class WorkersController < ApplicationController
  before_action { get_display_settings(:worker_id) }

  ##
  # Displays all worker info
  def view
    @sort_hash = get_proper_sort_categories([:worker_id, :name, :active])
    @workers = Worker.all.order(@sort_hash)
  end

  ##
  # Edits a worker's info
  def edit
    w_params = params[:worker]
    worker = Worker.find(w_params[:id])

    worker.worker_id = w_params[:worker_id]
    worker.name      = w_params[:name]
    worker.active    = w_params[:active]

    worker.save!
    redirect_back(fallback_location: view_workers_path)
  end

  ##
  # Deletes a worker's info
  def delete
    w_params = params[:worker]
    worker = Worker.find(w_params[:id])
    worker.destroy!
    redirect_back(fallback_location: view_workers_path)
  end

  def view_reports
    @worker = Worker.find(params[:worker_id])
    @spray_datum = Hash.new
    @dates = Set.new

    first_spray_of_week_date = nil
    spray_datum_all = SprayDatum.all.sort_by { |x| x.timestamp }
    spray_datum_all.each do |d|
      if d.sprayers.include?(@worker.worker_id)
        date = Date.strptime(d.timestamp)
        # Add data into @week_spray_datum
        if first_spray_of_week_date == nil or (date.cweek != first_spray_of_week_date.cweek)
          first_spray_of_week_date = date
          @spray_datum[date] = Hash.new
        end

        # Add data into @spray_datum
        date = "#{date.month}/#{date.day}/#{date.year}"
        if !@spray_datum[first_spray_of_week_date].key?(date)
          @spray_datum[first_spray_of_week_date][date] = []
        end
        @spray_datum[first_spray_of_week_date][date] << d
      end
    end

    
  end

end
