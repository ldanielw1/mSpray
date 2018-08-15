require 'csv'

##
# Controller managing data tables for admins
class WorkersController < ApplicationController
  before_action { get_display_settings(:worker_id) }

  ##
  #
  def view
    @sort_hash = get_proper_sort_categories([:worker_id, :name, :status])
    @workers = Worker.all.order(@sort_hash)
  end

end
