require 'fillable-pdf'

module PdfHelper
  SELECTION_MARK = "X"

  def set_field(field, value)
    @form.set_field(field, value)
  end

  def check_field(field)
    @form.set_field(field, SELECTION_MARK)
  end

  def uncheck_field(field)
    @form.set_field(field, "")
  end

  def download_and_delete(name)
    @form.save_as(name)
    File.open(name, "r") do |f|
      send_data f.read.force_encoding("BINARY"), :filename => name, :type => "application/pdf", :disposition => "attachment"
    end
    File.delete(name)
  end

  def default_data_fields
    return [:ddt_rooms_sprayed,
            :ddt_shelters_sprayed,
            :ddt_rooms_unsprayed,
            :ddt_refilled,
            :other_rooms_sprayed,
            :other_shelters_sprayed,
            :other_rooms_unsprayed,
            :other_refilled]
  end

  def default_data
    # Initialize all data with 0s
    data = Hash.new
    default_data_fields.each do |field|
      if field == :foreman
        data[field] = ""
      else
        data[field] = 0
      end
    end
    return data
  end

  def default_form_fields
    fields = Hash.new
    default_data_fields.each do |field|
      key = field.to_s
      key.gsub!(/_refilled/, "_refills")
      key.gsub!(/_.*_unsprayed/, "_unsprayed")
      key.gsub!(/_sprayed/, "")

      # Turn key into camel case
      split_key = key.split("_")
      split_key.each_with_index { |word, index| split_key[index] = split_key[index].capitalize if index > 0}
      key = split_key.join("")

      fields[key] = field
    end
    return fields
  end

end