class ChangeReportTimeTypeInMalariaReports < ActiveRecord::Migration[5.0]
  def change
    change_column :malaria_reports, :report_time, :string
  end
end
