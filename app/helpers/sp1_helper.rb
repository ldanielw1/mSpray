module Sp1Helper
  include PdfHelper

  # Creates a new SP1 form
  def create_sp1_form(spray_data, worker_id)
    @form = FillablePDF.new('public/assets/Form-SP1.pdf')
    set_field(:fieldOfficer, "Brenda Eskenazi")
    set_field(:district, "Vhembe")
    set_field(:locality, "Limpopo")

    set_field(:date, spray_data[:timestamp])
    set_field(:foreman, spray_data[:foreman])
    set_field(:sprayman, spray_data[:sprayer])
    set_chemical(spray_data[:chemical_used])

    set_field_and_check_boxes(:sprayedRooms, spray_data[:rooms_sprayed])
    set_field_and_check_boxes(:sprayedShelters, spray_data[:shelters_sprayed])
    set_field_and_check_boxes(:unsprayedRooms, spray_data[:rooms_unsprayed])
    set_field_and_check_boxes(:refills, spray_data[:refilled])

    timestamp_in_filename = Time.now.to_s.gsub(/[-:]/, '').split(" ")[0..1].join("_")
    download_and_delete("SP1_Form_#{worker_id}_#{timestamp_in_filename}.pdf")
  end

  def set_field_and_check_boxes(fieldName, value)
    check_boxes(fieldName, value)
    set_field(fieldName, value)
  end

  #records the chemical used for the spraying
  def set_chemical(chemical)
    [:ddtUsed, :baythroidUsed, :kothrineUsed].each { |chemical| uncheck_field(chemical) }
    if chemical.upcase == "DDT"
      check_field(:ddtUsed)
    elsif chemical.upcase == "K-ORTHRINE"
      check_field(:kothrineUsed)
    elsif chemical.upcase == "BAYTHROID"
      check_field(:baythroidUsed)
    elsif chemical.upcase == "FENDONA"
      set_field(:baythroidUsed, "Fendona")
    end
  end

  #checks off a number of boxes in a row
  def check_boxes(genericField, num_boxes)
    (1..num_boxes).each do |i|
      check_field(genericField.to_s + i.to_s)
    end
  end

end