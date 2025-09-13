#!/usr/bin/env ruby
def calendar

  require 'date'
  require 'optparse'

  #monthとyearの設定
  month = Date.today.month
  year = Date.today.year

  opt = OptionParser.new
  opt.on('-m [VAL]') { |v| month = v }
  opt.on('-y [VAL]') { |v| year = v }
  opt.parse!(ARGV)
  month = month.to_i
  year = year.to_i


  #表示内容を生成
  puts "       #{month}月 #{year}"
  puts " 日 月 火 水 木 金 土"
  firstDay = Date.new(year, month, 1)
  lastDay = Date.new(year, month, -1)
  dayOfWeek = firstDay.wday
  dayOfWeek.times{print "   "}
  for day in 1..lastDay.day
    print " " + sprintf("%2d",day) 
    if dayOfWeek % 7 == 6
      print "\n"
    end
    dayOfWeek += 1
  end
end
calendar