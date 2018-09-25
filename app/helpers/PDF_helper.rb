require 'fillable-pdf'
module PdfHelper
  global_pdf = nil
  SELECTION_MARK = "X"

  def set_pdf (fillable_pdf)
    global_pdf = fillable_pdf
  end

  def setField(field, value)
    global_pdf.set_field(field, value)
  end

  def checkField(field)
    global_pdf.set_field(field, SELECTION_MARK)
  end

  def uncheckField(field)
    global_pdf.set_field(field, "")
  end

  def save()
    global_pdf.save_as("test_form")
end