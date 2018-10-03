module Sp2Helper
  include PdfHelper

  def createSP2Form(spray_data, total_data, mopup_data, date)
    @form = FillablePDF.new('public/assets/Form-SP2.pdf')
    set_field(:region, "Limpopo")
    set_field(:sector, "Vhembe")
    set_field(:district, "Vhembe")
    set_field(:locality, "No Name")
    set_field(:team, "Team 1")
    set_field(:date, date)

    s_index = 1
    fields = Hash.new
    fields["sprayman"] = :sprayer
    fields["ddtRooms"] = :ddt_rooms_sprayed
    fields["ddtShelters"] = :ddt_shelters_sprayed
    fields["ddtUnsprayed"] = :ddt_rooms_unsprayed
    fields["ddtRefills"] = :ddt_refilled
    fields["otherRooms"] = :other_rooms_sprayed
    fields["otherShelters"] = :other_shelters_sprayed
    fields["otherUnsprayed"] = :other_rooms_unsprayed
    fields["otherRefills"] = :other_refilled
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

  # takes in hash
  def sp2_fill_init_data(spray_data)
    spray_data[:sprayer] = ""
    spray_data[:ddt_rooms_sprayed] = 0
    spray_data[:ddt_shelters_sprayed] = 0
    spray_data[:other_rooms_sprayed] = 0
    spray_data[:other_shelters_sprayed] = 0
    spray_data[:ddt_rooms_unsprayed] = 0
    spray_data[:other_rooms_unsprayed] = 0
    spray_data[:ddt_refilled] = 0
    spray_data[:other_refilled] = 0
    spray_data[:is_mopup] = false
    return spray_data
  end

end