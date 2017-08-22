#!/usr/bin/env ruby

top = File.dirname(File.expand_path(__FILE__))
require "#{top}/data_polling.rb"

desc "Update database from Google Sheets"
task :download_spray_data => :environment do
  ws, cols = get_worksheet()

  seeds_file = File.open("db/seeds.rb", 'w')
  print_seeds_rb_header(seeds_file)

  (2..ws.num_rows).each do |row_num|
    params, timestamp, sprayer_id = get_data(ws, cols, row_num)
    print_create_spray_datum(seeds_file, timestamp, sprayer_id, params)
  end

  seeds_file.close
end
