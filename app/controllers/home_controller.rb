class HomeController < ApplicationController
  def show
    gon.data = SprayDatum.all.map do |data|
      attribute_hash = data.attributes
      ["lat", "lon"].each { |label| attribute_hash[label] = attribute_hash[label].to_f }
      attribute_hash 
    end
  end
end
