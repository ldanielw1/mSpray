#!/usr/bin/env ruby

def print_usage
  puts
  puts "Usage: rake allow_email USER_EMAIL ON_OR_OFF"
  puts
  exit(0)
end

desc "Enable or disable users"
task :allow_email => :environment do

  print_usage if ARGV.length != 3

  ARGV.each { |a| task a.to_sym }
  input_email = ARGV[1].to_s
  on_or_off = ARGV[2].to_s

  allowed_statuses = ["off", "on"]
  print_usage if not allowed_statuses.include?(on_or_off)

  user_enabled = on_or_off == "on"
  user = AllowedEmail.where(email: input_email).first_or_initialize
  if user_enabled
    user.save!
  else
    user.destroy!
  end

end
