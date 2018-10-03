require 'csv'

##
# Controller managing data tables for admins
class WorkersController < ApplicationController
  include Sp1Helper
  include Sp2Helper
  include Sp3Helper

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

  def sp1_form
    worker = Worker.find(params[:worker_id])
    worker_id = worker.worker_id
    spray_date = params[:date]

    # This is where all data gets aggregated
    spray_data = Hash.new
    spray_data[:refilled] = 0
    spray_data[:rooms_sprayed] = 0
    spray_data[:shelters_sprayed] = 0
    spray_data[:rooms_unsprayed] = 0
    spray_data[:timestamp] = spray_date
    spray_data[:foreman] = ""
    spray_data[:sprayer] = "#{worker_id} - #{worker.name}"

    # Parse through all data in SprayDatum table
    data = SprayDatum.all.select { |d| d.sprayers.include?(worker_id) and d.timestamp.split(" ")[0] == spray_date }
    data = data.sort_by { |d| d.timestamp }
    data.each do |d|
      stats = d.stats[worker_id]
      (spray_data[:foreman] == "") ?  spray_data[:foreman] += "#{d.foreman}" : spray_data[:foreman] += ", #{d.foreman}" if !spray_data[:foreman].include?(d.foreman)
      spray_data[:chemical_used] = d.chemical_used
      spray_data[:refilled] += 1 if stats[:refilled]
      spray_data[:rooms_sprayed] += stats[:rooms_sprayed].to_i
      spray_data[:shelters_sprayed] += stats[:shelters_sprayed].to_i
      spray_data[:rooms_unsprayed] += stats[:rooms_unsprayed].to_i
      spray_data[:rooms_unsprayed] += stats[:shelters_unsprayed].to_i
    end

    create_sp1_form(spray_data, worker_id)
  end

  def sp2_form
    spray_date = params[:date]

    # This is where all data gets aggregated
    spray_data = Hash.new
    mopup_data = sp2_fill_init_data
    total_data = sp2_fill_init_data
    foremen = ""

    # Parse through all SprayDatum objects
    data = SprayDatum.all.select { |d| d.timestamp.split(" ")[0] == spray_date }
    data = data.sort_by{ |d| d.timestamp }
    data.each do |d|
      (foremen == "") ?  foremen += "#{d.foreman}" : foremen += ", #{d.foreman}" if !foremen.include?(d.foreman)
      d.sprayers.each do |w_id|
        # Get worker and spray data
        worker = Worker.find(w_id)
        worker_id = worker.worker_id
        stats = d.stats[worker_id]
        chemical = d.chemical_used.upcase == "DDT" ? :ddt : :other

        # Initialize empty worker data in spray_data
        if not spray_data.has_key?(worker_id)
          spray_data[worker_id] = sp2_fill_init_data()
          spray_data[worker_id][:sprayer] = "#{worker_id} - #{worker.name}"
        end

        # Update all affected datasets with this spray datum
        categories = [:rooms_sprayed, :shelters_sprayed, :rooms_unsprayed, :refilled]
        affected_datasets = [spray_data[worker_id], total_data]
        affected_datasets << mopup_data if d.is_mopup_spray
        affected_datasets.each do |dataset|
          categories.each do |category|
            new_category = "#{chemical}_#{category}".to_sym
            if category == :refilled
              dataset[new_category] += 1 if stats[category]
            else
              dataset[new_category] += stats[category].to_i
            end
          end
        end
      end
    end
    create_sp2_form(spray_data, total_data, mopup_data, spray_date, foremen)
  end

  def sp3_form
    week = params[:week].to_i
    first_of_week = nil
    foremen = ""

    spray_data = Hash.new # date => {data per day}
    worker_per_day = Hash.new # date => [worker]
    total_data = sp3_fill_init_data

    data = SprayDatum.all.select { |d| Date.strptime(d.timestamp).cweek == week }
    data = data.sort_by{ |d| d.timestamp }
    data.each do |d|
      (foremen == "") ?  foremen += "#{d.foreman}" : foremen += ", #{d.foreman}" if !foremen.include?(d.foreman)

      date = d.timestamp.split(" ")[0]
      worker_per_day[date] = [] if not worker_per_day.has_key?(date)
      spray_data[date] = sp3_fill_init_data if not spray_data.has_key?(date)
      first_of_week = Date.strptime(d.timestamp) if first_of_week ==  nil

      chemical = d.chemical_used.upcase == "DDT" ? :ddt : :other

      d.sprayers.each do |w_id|
        new_worker_on_day = !worker_per_day[date].include?(w_id)
        worker_per_day[date] << w_id if new_worker_on_day

        stats = d.stats[w_id]
        affected_datasets = [spray_data[date], total_data]
        affected_datasets.each do |dataset|
          dataset[:sprayman_days] += 1 if new_worker_on_day

          categories = [:rooms_sprayed, :shelters_sprayed, :rooms_unsprayed, :refilled]
          categories.each do |category|
            new_category = "#{chemical}_#{category}".to_sym
            if category == :refilled
              dataset[new_category] += 1 if stats[category]
            else
              dataset[new_category] += stats[category].to_i
            end
          end
        end
      end
    end

    create_sp3_form(spray_data, total_data, first_of_week, foremen)
  end

end
