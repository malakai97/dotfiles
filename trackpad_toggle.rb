#!/usr/bin/env ruby

mode = ARGV.first
case mode
when "on"
  `xinput set-prop 11 "Device Enabled" 1`
when "off"
  `xinput set-prop 11 "Device Enabled" 0`
else
  puts "Didn't understand argument #{mode}, use off or on"
end

