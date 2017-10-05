#!/usr/bin/env ruby

list = `xinput`
puts list
puts "\nPlease select the id corresponding to the trackpad from the above list:"
choice = gets.strip

script = '#!/usr/bin/env ruby

mode = ARGV.first
case mode
when "on"
  `xinput set-prop ' + choice + ' "Device Enabled" 1`
when "off"
  `xinput set-prop ' + choice + ' "Device Enabled" 0`
else
  puts "Didn\'t understand argument #{mode}, use off or on"
end
'

File.write("./trackpad_toggle.rb", script)
