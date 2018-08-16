#!/usr/bin/env ruby

##
# Returns the worksheet object, columns hash for the mspray input data.
def get_worker_data_worksheet(session)
  return get_worksheet(session, '1-66XCe_Uq9XnfiXpBWNqAVGmZHLK0JE_arSuq1cEsjg')
end

##
# Gets data out of one row of the worksheet
def get_worker_data(ws, cols, row)
  params = Hash.new
  params[:worker_id] = ws[row, cols['Worker ID']]
  params[:name]    = ws[row, cols['Name']]
  params[:active]  = ws[row, cols['Active?']] == "TRUE"

  return params
end

##
# Print line to create SprayDatum object
def print_create_worker(file, params)
  file.puts "create_worker('#{params[:worker_id]}', '#{params[:name]}', #{params[:active]})\n"
end
