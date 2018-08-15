#!/usr/bin/env ruby

##
# Pads input numbers with leading zeroes if needed.
def pad_num(number, total_digits)
  return number.to_s.rjust(total_digits, '0')
end

##
# Converts a DateTime timestamp into a string
def timestamp_to_str(timestamp)
  return "#{pad_num(timestamp.year, 4)}-#{pad_num(timestamp.month, 2)}-#{pad_num(timestamp.day, 2)} #{pad_num(timestamp.hour, 2)}:#{pad_num(timestamp.minute, 2)}:#{pad_num(timestamp.second, 2)}"
end

##
# Get DateTime timestamp data out of Android-outputted string
def get_timestamp(timestamp_string)
  return DateTime.strptime(timestamp_string, '%m/%e/%Y %H:%M:%S')
end

##
# Get boolean value of a string's contents
def get_bool(bool_string)
  return true if bool_string =~ /true/i
  return false
end
