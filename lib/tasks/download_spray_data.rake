#!/usr/bin/env ruby

top = File.dirname(File.expand_path(__FILE__))
require "#{top}/utils/generate_seeds_rb_utils.rb"

desc "Update database from Google Sheets"
task :download_spray_data => :environment do
  seeds_file = File.open("db/seeds.rb", 'w')
  print_seeds_rb_header(seeds_file)

  google_session = get_session()

  worker_ws, worker_cols = get_worker_data_worksheet(google_session)
  (2..worker_ws.num_rows).each do |row|
    params = get_worker_data(worker_ws, worker_cols, row)
    print_create_worker(seeds_file, params)
  end
  seeds_file.puts

  spray_ws, spray_cols = get_spray_data_worksheet(google_session)
  (2..spray_ws.num_rows).each do |row|
    params = get_spray_data(spray_ws, spray_cols, row)
    print_create_spray_datum(seeds_file, params)
  end

  seeds_file.close
end
