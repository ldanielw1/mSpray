desc "Update database from Google Sheets"
task :db_update => :environment do
  TIMESTAMP = 2
  LAT = 32
  LON = 33
  ACCURACY = 8
  HOMESTEAD_SPRAYED = 9
  SPRAYER_ID = 10
  SPRAYER_2_ID = 11
  DDT_USED_1 = 12
  DDT_SPRAYED_ROOMS_1 = 13
  DDT_SPRAYED_SHELTERS_1 = 14
  DDT_REFILL_1 = 15
  PYRETHROID_USED_1 = 16
  PYRETHROID_SPRAYED_ROOMS_1 = 17
  PYRETHROID_SPRAYED_SHELTERS_1 = 18
  PYRETHROID_REFILL_1 = 19
  DDT_USED_2 = 20
  DDT_SPRAYED_ROOMS_2 = 21
  DDT_SPRAYED_SHELTERS_2 = 22
  DDT_REFILL_2 = 23
  PYRETHROID_USED_2 = 23
  PYRETHROID_SPRAYED_ROOMS_2 = 25
  PYRETHROID_SPRAYED_SHELTERS_2 = 26
  PYRETHROID_REFILL_2 = 27
  UNSPRAYED_ROOMS = 28
  UNSPRAYED_SHELTERS = 29
  FOREMAN = 30

  # Creates a session for the update
  session = GoogleDrive::Session.from_service_account_key("config/mSprayServiceAccountKey.json")
  ws = session.spreadsheet_by_key("1QuYwTV8VRIO8zB-O7TR_ZYJ9vKX2gh4Z79upSHTaMs8").worksheets[0]

  bottom_row_num = ws.num_rows

end
