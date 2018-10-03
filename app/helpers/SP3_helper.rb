require 'pdf_helper'

module Sp3Helper
  include PdfHelper

  def createSP3Form(spray_data, total_data, first_of_week)

    @form = FillablePDF.new('public/assets/Form-SP3.pdf')
    set_field(:region, "Limpopo")
    set_field(:team, "Team 1")
    set_field(:district, "Vhembe")
    set_field(:sector, "Vhembe")

    week_begin = first_of_week - first_of_week.wday
    week_end = first_of_week + (6 - first_of_week.wday)
    set_field(:dateFrom, week_begin)
    set_field(:dateTo, week_end)

    s_index = 1
    fields = Hash.new
    fields["ddtRooms"] = :ddt_rooms_sprayed
    fields["ddtShelters"] = :ddt_shelters_sprayed
    fields["otherRooms"] = :other_rooms_sprayed
    fields["otherShelters"] = :other_shelters_sprayed
    fields["ddtUnsprayed"] = :ddt_rooms_unsprayed
    fields["otherUnsprayed"] = :other_rooms_unsprayed
    fields["ddtRefills"] = :ddt_refilled
    fields["otherRefills"] = :other_refilled
    fields["spraymanDays"] = :sprayman_days
    spray_data.each do |w_date, d|
      fields.each { |field, date_field| set_field((field + s_index.to_s).to_sym, d[date_field])}
      set_field(("date" + s_index.to_s).to_sym, w_date)
      set_field(("locality" + s_index.to_s).to_sym, "Limpopo")
      s_index += 1
    end
    fields.each { |field, date_field| set_field((field + "Final").to_sym, total_data[date_field])}

    date = spray_data.keys[0]
    timestamp_in_filename = Time.now.to_s.gsub(/[-:]/, '').split(" ")[0..1].join("_")
    download_and_delete("SP3_Form_#{date.gsub(/[-]/, '')}_#{timestamp_in_filename}.pdf")
  end

  def sp3_fill_init_data(spray_data)
    spray_data[:ddt_rooms_sprayed] = 0
    spray_data[:ddt_shelters_sprayed] = 0
    spray_data[:other_rooms_sprayed] = 0
    spray_data[:other_shelters_sprayed] = 0
    spray_data[:ddt_rooms_unsprayed] = 0
    spray_data[:other_rooms_unsprayed] = 0
    spray_data[:ddt_refilled] = 0
    spray_data[:other_refilled] = 0
    spray_data[:sprayman_days] = 0;
    return spray_data
  end
end