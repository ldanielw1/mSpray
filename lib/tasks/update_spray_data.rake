#!/usr/bin/env ruby

top = File.dirname(File.expand_path(__FILE__))
require "#{top}/utils/generate_seeds_rb_utils.rb"

desc "Update database from Google Sheets, but only with data newer than latest SprayDatum submission"
task :update_spray_data => :environment do
  spray_date_array = SprayDatum.all.pluck(:timestamp).sort
  if spray_date_array.length == 0
    puts
    puts "No data to update. Please run `rake download_spray_data` instead."
    puts
    exit(0)
  end
  last_spray_date = spray_date_array[-1]

  seeds_file = File.open("db/seeds.rb", 'w')
  print_seeds_rb_header(seeds_file)

  google_session = get_session()

  worker_ws, worker_cols = get_worker_worksheet(google_session)
  (2..worker_ws.num_rows).each do |row|
    timestamp = get_timestamp(worker_ws[row, worker_cols['timeStamp']])
    params = get_worker_data(worker_ws, worker_cols, row)
    print_create_spray_datum(seeds_file, params)
  end
  seeds_file.puts

  spray_ws, spray_cols = get_spray_data_worksheet(google_session)
  (2..spray_ws.num_rows).each do |row|
    timestamp = get_timestamp(spray_ws[row, spray_cols['timeStamp']])
    next if timestamp < last_spray_date

    params = get_spray_data(spray_ws, spray_cols, row)
    print_create_spray_datum(seeds_file, params)
  end
  seeds_file.close
end
