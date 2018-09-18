desc "Toggle the given users Admin status"
task :toggle_admin_settings do

  ARGV.each { |a| task a.to_sym do ; end }
     
  email = ARGV[1].to_s
  status = ARGV[2].to_s

  if ARGV.length <= 1
    puts
    puts "Please enter Email and Status"
    puts
  end


end
