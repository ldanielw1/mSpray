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

end
