require 'csv'

##
# Controller managing data tables for admins
class SprayDataController < ApplicationController
  before_action { get_display_settings(:timestamp) }

  ##
  # Display all spray data
  def view
    @sort_hash = get_proper_sort_categories([:sprayers, :lat, :lng])
    @data = SprayDatum.all.order(@sort_hash)
  end

  ##
  # Edits a spray datum
  def edit
    if current_user.admin?
      sd_params = params[:spray_datum]
      spray_datum = SprayDatum.find(sd_params[:id])

      spray_datum.foreman             = sd_params[:foreman]
      spray_datum.is_mopup_spray      = sd_params[:is_mopup_spray] == "1" ? "true" : "false"
      spray_datum.chemical_used       = sd_params[:chemical_used]
      spray_datum.unsprayed_rooms     = sd_params[:unsprayed_rooms].to_i
      spray_datum.unsprayed_shelters  = sd_params[:unsprayed_shelters].to_i

      new_stats_hash = Hash.new
      sd_params[:stats].each do |old_sprayer, stats|
        new_stats_hash[stats[:name]] = Hash.new
        [:rooms_sprayed, :shelters_sprayed].each do |label|
          new_stats_hash[stats[:name]][label] = stats[label]
        end
        new_stats_hash[stats[:name]][:refilled] = "1" ? "true" : "false"
      end
      spray_datum.stats = new_stats_hash
      spray_datum.save!

      g_drive = GoogleDrive::Session.from_service_account_key("config/mSprayServiceAccountKey.json")
      work_sheet = g_drive.spreadsheet_by_name("mSpray 2.0 Results").worksheets[0]
      row_num = 1
      work_sheet.rows.drop(1).each do |row|
        row_num += 1
        if ((Time.strptime(row[0],"%m/%d/%Y %H:%M:%S") == Time.parse(spray_datum.timestamp)) && (row[9].to_f == spray_datum.lat) && (row[10].to_f == spray_datum.lng))
          work_sheet[row_num, 3] = spray_datum.foreman
          work_sheet[row_num, 4] = spray_datum.chemical_used
          work_sheet[row_num, 5] = spray_datum.stats
          work_sheet[row_num, 6] = spray_datum.unsprayed_rooms
          work_sheet[row_num, 7] = spray_datum.unsprayed_shelters
          work_sheet[row_num, 9] = spray_datum.is_mopup_spray
          work_sheet.save()
          break
        end
      end
    else
      flash[:error] = "#{current_user.name} (#{current_user.email}) does not have the privileges to edit spray data"
    end
    redirect_back(fallback_location: view_spray_data_path)
  end

  ##
  # Delete one instance of spray data
  def delete
    if current_user.admin?
      datum = SprayDatum.find(params[:spray_datum][:id])
      g_drive = GoogleDrive::Session.from_service_account_key("config/mSprayServiceAccountKey.json")
      work_sheet = g_drive.spreadsheet_by_name("mSpray 2.0 Results").worksheets[0]
      row_num = 1
      work_sheet.rows.drop(1).each do |row|
        row_num += 1
        if ((Time.strptime(row[0],"%m/%d/%Y %H:%M:%S") == Time.parse(datum.timestamp)) && (row[9].to_f == datum.lat) && (row[10].to_f == datum.lng))
          work_sheet.delete_rows(row_num, 1)
          break
        end
      end
      datum.destroy!
    else
      flash[:error] = "#{current_user.name} (#{current_user.email}) does not have the privileges to delete spray data"
    end
    redirect_back(fallback_location: view_spray_data_path)
  end

  def add
    if current_user.admin?
      puts(params[:spray_datum])

    else
      flash[:error] = "#{current_user.name} (#{current_user.email}) does not have the privileges to edit spray data"
    end
    redirect_back(fallback_location: root_path)
  end

end
