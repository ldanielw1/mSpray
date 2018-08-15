#!/usr/bin/env ruby

top = File.dirname(File.expand_path(__FILE__))
require "#{top}/data_utils.rb"
require "#{top}/worksheet_utils.rb"

require "#{top}/spray_data_utils.rb"
require "#{top}/worker_utils.rb"

##
# Print seeds.rb header into input file
def print_seeds_rb_header(file)
  file.puts "#!/usr/bin/env ruby"
  file.puts
  file.puts "include SprayDatumHelper"
  file.puts "include WorkerHelper"
  file.puts
end
