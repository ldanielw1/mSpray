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
end