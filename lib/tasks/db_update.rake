desc "Update database from Google Sheets"
task :db_update => :environment do
  session = GoogleDrive::Session.from_service_account_key('config/mSprayServiceAccountKey.json')
  ws = session.spreadsheet_by_key('1QuYwTV8VRIO8zB-O7TR_ZYJ9vKX2gh4Z79upSHTaMs8').worksheets[0]
  end_col_num = ws.num_cols
  cols = Hash.new

  (1..end_col_num).each do |col_num|
    cols[ws[1, col_num]] = col_num
   end
  
  seeds_file = File.open("db/seeds.rb", 'w')

  seeds_file.puts "include SprayDatumHelper"
  (2..ws.num_rows).each do |row_num|

    time_stamp = DateTime.strptime(ws[row_num, cols['timeStamp']], '%m/%e/%Y %H:%M:%S')
    sprayer_id = ws[row_num, cols['sprayerID']]
    
    params = Hash.new
    params[:accuracy] =                         ws[row_num, cols['accuracy']]
    params[:lat] =                              ws[row_num, cols['newlat']]
    params[:lng] =                              ws[row_num, cols['newlng']]
    params[:homestead_sprayed] =                ws[row_num, cols['homesteadSprayed']]
    params[:sprayer_id] =                       sprayer_id
    params[:DDT_used_1] =                       ws[row_num, cols['DDTUsed1']]
    params[:DDT_sprayed_rooms_1] =              ws[row_num, cols['DDTSprayedRooms1']]
    params[:DDT_sprayed_shelters_1] =           ws[row_num, cols['DDTSprayedShelters1']]
    params[:DDT_refill_1] =                     ws[row_num, cols['DDTRefill1']]
    params[:pyrethroid_used_1] =                ws[row_num, cols['pyrethroidUsed1']]
    params[:pyrethroid_sprayed_rooms_1] =       ws[row_num, cols['pyrethroidSprayedRooms1']]
    params[:pyrethroid_sprayed_shelters_1] =    ws[row_num, cols['pyrethroidSprayedShelters1']]
    params[:pyrethroid_refill_1] =              ws[row_num, cols['pyrethroidRefill1']]
    params[:DDT_used_2] =                       ws[row_num, cols['DDTUsed2']]
    params[:DDT_sprayed_rooms_2] =              ws[row_num, cols['DDTSprayedRooms2']]
    params[:DDT_sprayed_shelters_2] =           ws[row_num, cols['DDTSprayedShelters2']]
    params[:DDT_refill_2] =                     ws[row_num, cols['DDTRefill2']]
    params[:pyrethroid_used_2] =                ws[row_num, cols['pyrethroidUsed2']]
    params[:pyrethroid_sprayed_rooms_2] =       ws[row_num, cols['pyrethroidSprayedRooms2']]
    params[:pyrethroid_sprayed_shelters_2] =    ws[row_num, cols['pyrethroidSprayedShelters2']]
    params[:pyrethroid_refill_2] =              ws[row_num, cols['pyrethroidRefill2']]
    params[:foreman] =                          ws[row_num, cols['foreman']]
    params[:unsprayed_rooms] =                  ws[row_num, cols['unsprayedRooms']]
    params[:unsprayed_shelters] =               ws[row_num, cols['unsprayedShelters']]

    seeds_file.puts "create_spray_datum('#{time_stamp}', '#{sprayer_id}', #{params})\n"
  end
  
  seeds_file.close
end
