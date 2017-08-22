#!/usr/bin/env ruby

top = File.dirname(File.expand_path(__FILE__))
require "#{top}/data_polling.rb"

desc "Update database from Google Sheets"
task :update_spray_data => :environment do
  spray_date_array = SprayDatum.all.pluck(:timeStamp).sort
  if spray_date_array.length == 0
    puts
    puts "No data to update. Please run `rake download_spray_data` instead."
    puts
    exit(0)
  end
  last_spray_date = last_spray_date[-1]
  ws, cols = get_worksheet()

  seeds_file = File.open("db/seeds.rb", 'w')
  print_seeds_rb_header(seeds_file)

  (2..ws.num_rows).each do |row_num|
    timestamp = get_timestamp(ws[row_num, cols['timeStamp']])
    next if timestamp < last_spray_date

    params, timestamp, sprayer_id = get_data(ws, cols, row_num)
    print_create_spray_datum(seeds_file, timestamp, sprayer_id, params)
  end

  seeds_file.close
end
