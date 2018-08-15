#!/usr/bin/env ruby

##
# Returns the worksheet object, columns hash for the mspray input data.
def get_spray_data_worksheet(session)
  return get_worksheet(session, '1QuYwTV8VRIO8zB-O7TR_ZYJ9vKX2gh4Z79upSHTaMs8')
end

##
# Gets data out of one row of the worksheet
def get_spray_data(ws, cols, row_num)
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
