# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

(2..bottom_row_num).each do |row_num|
  sd = SprayDatum.new

  sd.timeStamp =                     ws[row_num, TIMESTAMP]
  sd.lat =                           ws[row_num, LAT]
  sd.lon =                           ws[row_num, LON]
  sd.accuracy =                      ws[row_num, ACCURACY]
  sd.homesteadSprayed =              ws[row_num, HOMESTEAD_SPRAYED]
  sd.sprayerID =                     ws[row_num, SPRAYER_ID]
  sd.sprayer2ID =                    ws[row_num, SPRAYER_2_ID]
  sd.DDTUsed1 =                      ws[row_num, DDT_USED_1]
  sd.DDTSprayedRooms1 =              ws[row_num, DDT_SPRAYED_ROOMS_1]
  sd.DDTSprayedShelters1 =           ws[row_num, DDT_SPRAYED_SHELTERS_1]
  sd.DDTRefill1 =                    ws[row_num, DDT_REFILL_1]
  sd.pyrethroidUsed1 =               ws[row_num, PYRETHROID_USED_1]
  sd.pyrethroidSprayedRooms1 =       ws[row_num, PYRETHROID_SPRAYED_ROOMS_1]
  sd.pyrethroidSprayedShelters1 =    ws[row_num, PYRETHROID_SPRAYED_SHELTERS_1]
  sd.pyrethroidRefill1 =             ws[row_num, PYRETHROID_REFILL_1]
  sd.DDTUsed2 =                      ws[row_num, DDT_USED_2]
  sd.DDTSprayedRooms2 =              ws[row_num, DDT_SPRAYED_ROOMS_2]
  sd.DDTSprayedShelters2 =           ws[row_num, DDT_SPRAYED_SHELTERS_2]
  sd.DDTRefill2 =                    ws[row_num, DDT_REFILL_2]
  sd.pyrethroidUsed2 =               ws[row_num, PYRETHROID_USED_2]
  sd.pyrethroidSprayedRooms2 =       ws[row_num, PYRETHROID_SPRAYED_ROOMS_2]
  sd.pyrethroidSprayedShelters2 =    ws[row_num, PYRETHROID_SPRAYED_SHELTERS_2]
  sd.pyrethroidRefill2 =             ws[row_num, PYRETHROID_REFILL_2]
  sd.unsprayedRooms =                ws[row_num, UNSPRAYED_ROOMS]
  sd.unsprayedShelters =             ws[row_num, UNSPRAYED_SHELTERS]
  sd.foreman =                       ws[row_num, FOREMAN]

  sd.save
end

s = SprayDatum.find_by(lat: -22.87852012)
if s.lon = 30.72852177
  puts "******* Seed completed without errors *******"
end

