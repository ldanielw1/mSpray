#!/usr/bin/env ruby

## Returns the session object for getting worksheets
def get_session()
  return GoogleDrive::Session.from_service_account_key('config/mSprayServiceAccountKey.json')
end

##
# Returns the worksheet object, columns hash for the mspray input data.
def get_worksheet(session, worksheet_key)
  ws = session.spreadsheet_by_key(worksheet_key).worksheets[0]

  cols = Hash.new
  (1..ws.num_cols).each do |col_num|
    cols[ws[1, col_num]] = col_num
  end

  return ws, cols
end
