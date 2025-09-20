#!/usr/bin/env ruby
def calendar
  require 'date'
  require 'optparse'

  month = Date.today.month
  year = Date.today.year

  opt = OptionParser.new
  opt.on('-m [VAL]') { |v| month = v.to_i }
  opt.on('-y [VAL]') { |v| year = v.to_i }
  opt.parse!(ARGV)

  puts "       #{month}月 #{year}"
  puts '日 月 火 水 木 金 土'
  first_date = Date.new(year, month, 1)
  last_date = Date.new(year, month, -1)
  print '   ' * first_date.wday
  (first_date..last_date).each do |date|
    print format('%2d ', date.day)
    print "\n" if date.saturday?
  end
  puts "\n"
end
calendar
