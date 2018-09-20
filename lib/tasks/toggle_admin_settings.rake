#!/usr/bin/env ruby

def print_usage
  puts
  puts "Usage: rake toggle_admin_settings USER ON_OR_OFF"
  puts
  exit(0)
end

desc "Toggle the given users Admin status"
task :toggle_admin_settings => :environment do

  print_usage if ARGV.length != 3

  ARGV.each { |a| task a.to_sym }
  input_email = ARGV[1].to_s
  admin_status = ARGV[2].to_s

  allowed_statuses = ["off", "on"]
  print_usage if not allowed_statuses.include?(admin_status)

  new_admin_status = admin_status == "on"
  edit_user = User.find_by_email(input_email)
  edit_user.update_attribute(:admin, new_admin_status)

end
