require 'csv'

##
# Controller managing data tables for admins
class DataController < ApplicationController
  before_action :admin_only
  before_action { get_display_settings(:sprayer_id) }

  ##
  # 
  def view
    @sort_hash = get_proper_sort_categories([:sprayer_id, :lat, :lon])
    @data = SprayDatum.all.order(@sort_hash)
  end

end