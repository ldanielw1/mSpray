#!/usr/bin/env ruby

require 'json'

##
# Returns the worksheet object, columns hash for the mspray input data.
def get_spray_data_worksheet(session)
#  return get_worksheet(session, '1QuYwTV8VRIO8zB-O7TR_ZYJ9vKX2gh4Z79upSHTaMs8')  for 1.5 results
  return get_worksheet(session, '1tRO-wfk-0aQeYFeGQumTG8l_hC8k5XKozyltAVFxpQ4')
end

##
# Gets data out of one row of the worksheet
def get_spray_data(ws, cols, row_num)
  timestamp = timestamp_to_str(get_timestamp(ws[row_num, cols['timeStamp']]))

  # Organize stats in ruby format
  stats = Hash.new
  JSON.parse(ws[row_num, cols['stats']]).each do |sprayer, s_stats|
    stats[sprayer] = Hash.new
    stats[sprayer][:rooms_sprayed] = s_stats["roomsSprayed"]
    stats[sprayer][:shelters_sprayed] = s_stats["sheltersSprayed"]
    stats[sprayer][:refilled] = s_stats["refilled"]
  end

  # Organize attrs as params
  params = Hash.new
  params[:timestamp]          = timestamp
  params[:imei]               = ws[row_num, cols['imei']]
  params[:lat]                = ws[row_num, cols['lat']]
  params[:lng]                = ws[row_num, cols['lng']]
  params[:gps_accuracy]       = ws[row_num, cols['accuracy']]
  params[:is_mopup_spray]     = ws[row_num, cols['isMopUpSpray']]
  params[:foreman]            = ws[row_num, cols['foreman']]
  params[:chemical_used]      = ws[row_num, cols['chemicalUsed']]
  params[:unsprayed_rooms]    = ws[row_num, cols['unsprayedRooms']].to_i
  params[:unsprayed_shelters] = ws[row_num, cols['unsprayedShelters']].to_i
  params[:stats]              = stats

  return params
end

##
# Print line to create SprayDatum object
def print_create_spray_datum(file, params)
  file.puts "create_spray_datum(#{params})\n"
end
