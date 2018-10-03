module Sp2Helper
  include PdfHelper

  def create_sp2_form(spray_data, total_data, mopup_data, date, foremen)
    @form = FillablePDF.new('public/assets/Form-SP2.pdf')
    set_field(:region, "Limpopo")
    set_field(:sector, "Vhembe")
    set_field(:district, "Vhembe")
    set_field(:locality, "No Name")
    set_field(:team, foremen)
    set_field(:date, date)

    s_index = 1
    fields = default_form_fields
    fields["sprayman"] = :sprayer
    spray_data.each do |w_id, d|
      fields.each { |field, data_field| set_field((field + s_index.to_s).to_sym, d[data_field]) }
      s_index += 1
    end

    fields.delete("sprayman")
    [[:Total, total_data], [:Mopup, mopup_data]].each do |category, dataset|
      fields.each do |field, data_field|
        new_field = "#{field}#{category}".to_sym
        set_field(new_field, dataset[data_field])
      end
    end

    timestamp_in_filename = Time.now.to_s.gsub(/[-:]/, '').split(" ")[0..1].join("_")
    download_and_delete("SP2_Form_#{date.gsub(/[-]/, '')}_#{timestamp_in_filename}.pdf")
  end

  def sp2_fill_init_data
    spray_data = default_data
    spray_data[:sprayer] = ""
    spray_data[:is_mopup] = false
    return spray_data
  end

end