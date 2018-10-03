require 'pdf_helper'

module Sp3Helper
  include PdfHelper

  def create_sp3_form(spray_data, total_data, first_of_week, foremen)

    @form = FillablePDF.new('public/assets/Form-SP3.pdf')
    set_field(:region, "Limpopo")
    set_field(:team, foremen)
    set_field(:district, "Vhembe")
    set_field(:sector, "Vhembe")

    week_begin = first_of_week - first_of_week.wday
    week_end = first_of_week + (6 - first_of_week.wday)
    set_field(:dateFrom, week_begin)
    set_field(:dateTo, week_end)

    s_index = 1
    fields = default_form_fields
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

  def sp3_fill_init_data()
    spray_data = default_data
    spray_data[:sprayman_days] = 0;
    return spray_data
  end
end