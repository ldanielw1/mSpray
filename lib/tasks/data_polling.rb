#!/usr/bin/env ruby

##
# Pads input numbers with leading zeroes if needed.
def pad_num(number, total_digits)
  return number.to_s.rjust(total_digits, '0')
end

##
# Returns the worksheet object, columns hash for the mspray input data.
def get_worksheet()
  session = GoogleDrive::Session.from_service_account_key('config/mSprayServiceAccountKey.json')
  ws = session.spreadsheet_by_key('1QuYwTV8VRIO8zB-O7TR_ZYJ9vKX2gh4Z79upSHTaMs8').worksheets[0]

  cols = Hash.new
  (1..ws.num_cols).each do |col_num|
    cols[ws[1, col_num]] = col_num
  end

  return ws, cols
end

##
# Print seeds.rb header into input file
def print_seeds_rb_header(file)
  file.puts "#!/usr/bin/env ruby"
  file.puts
  file.puts "include SprayDatumHelper"
  file.puts
end

##
# Converts a DateTime timestamp into a string
def timestamp_to_str(timestamp)
  return "#{pad_num(timestamp.year, 4)}-#{pad_num(timestamp.month, 2)}-#{pad_num(timestamp.day, 2)} #{pad_num(timestamp.hour, 2)}:#{pad_num(timestamp.minute, 2)}:#{pad_num(timestamp.second, 2)}"
end

##
# Get DateTime timestamp data out of Android-outputted string
def get_timestamp(timestamp_string)
  return DateTime.strptime(timestamp_string, '%m/%e/%Y %H:%M:%S')
end

##
# Get boolean value of a string's contents
def get_bool(bool_string)
  return true if bool_string =~ /true/i
  return false
end

##
# Gets data out of one row of the worksheet
def get_data(ws, cols, row_num)
  timestamp = timestamp_to_str(get_timestamp(ws[row_num, cols['timeStamp']]))
  sprayer_id = ws[row_num, cols['sprayerID']]

  params = Hash.new
  params[:accuracy] =                         ws[row_num, cols['accuracy']]
  params[:lat] =                              ws[row_num, cols['newlat']]
  params[:lng] =                              ws[row_num, cols['newlng']]
  params[:homestead_sprayed] =                get_bool(ws[row_num, cols['homesteadSprayed']])
  params[:sprayer_id] =                       sprayer_id
  params[:ddt_used_1] =                       get_bool(ws[row_num, cols['DDTUsed1']])
  params[:ddt_sprayed_rooms_1] =              ws[row_num, cols['DDTSprayedRooms1']].to_i
  params[:ddt_sprayed_shelters_1] =           ws[row_num, cols['DDTSprayedShelters1']].to_i
  params[:ddt_refill_1] =                     get_bool(ws[row_num, cols['DDTRefill1']])
  params[:pyrethroid_used_1] =                get_bool(ws[row_num, cols['pyrethroidUsed1']])
  params[:pyrethroid_sprayed_rooms_1] =       ws[row_num, cols['pyrethroidSprayedRooms1']].to_i
  params[:pyrethroid_sprayed_shelters_1] =    ws[row_num, cols['pyrethroidSprayedShelters1']].to_i
  params[:pyrethroid_refill_1] =              get_bool(ws[row_num, cols['pyrethroidRefill1']])
  params[:ddt_used_2] =                       get_bool(ws[row_num, cols['DDTUsed2']])
  params[:ddt_sprayed_rooms_2] =              ws[row_num, cols['DDTSprayedRooms2']].to_i
  params[:ddt_sprayed_shelters_2] =           ws[row_num, cols['DDTSprayedShelters2']].to_i
  params[:ddt_refill_2] =                     get_bool(ws[row_num, cols['DDTRefill2']])
  params[:pyrethroid_used_2] =                get_bool(ws[row_num, cols['pyrethroidUsed2']])
  params[:pyrethroid_sprayed_rooms_2] =       ws[row_num, cols['pyrethroidSprayedRooms2']].to_i
  params[:pyrethroid_sprayed_shelters_2] =    ws[row_num, cols['pyrethroidSprayedShelters2']].to_i
  params[:pyrethroid_refill_2] =              get_bool(ws[row_num, cols['pyrethroidRefill2']])
  params[:foreman] =                          ws[row_num, cols['foreman']]
  params[:unsprayed_rooms] =                  ws[row_num, cols['unsprayedRooms']].to_i
  params[:unsprayed_shelters] =               ws[row_num, cols['unsprayedShelters']].to_i

  return params, timestamp, sprayer_id
end

##
# Print line to create SprayDatum object
def print_create_spray_datum(file, timestamp, sprayer_id, params)
  file.puts "create_spray_datum('#{timestamp}', '#{sprayer_id}', #{params})\n"
end
