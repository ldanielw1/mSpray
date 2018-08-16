require 'csv'

##
# Controller managing data tables for admins
class SprayDataController < ApplicationController
  before_action { get_display_settings(:timestamp) }

  ##
  #
  def view
    @sort_hash = get_proper_sort_categories([:sprayers, :lat, :lon])
    @data = SprayDatum.all.order(@sort_hash)
  end

end
