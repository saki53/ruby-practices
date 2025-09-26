# frozen_string_literal: true

# !/usr/bin/env ruby
require 'optparse'

NUM_COLUMNS = 3

# 行ごとに分割した配列を作成する関数
def create_rows(files, columns_count)
  row_count = files.size.ceildiv(columns_count)
  rows = Array.new(row_count) { [] }
  files.each_with_index do |file, index|
    rows[index % row_count] << file
  end
  rows
end

# 各行の要素を横幅を揃えて整形する関数
def format_rows(rows)
  max_len = rows.flatten.map(&:length).max
  rows.map do |row|
    row.map do |file_name|
      file_name.to_s.ljust(max_len + 1)
    end
  end
end

# メイン処理
show_all = false
opt = OptionParser.new
opt.on('-a') { show_all = true }
opt.parse!(ARGV)

files =
  if show_all
    Dir.glob(['*', '.*']).sort
  else
    Dir.glob('*').sort
  end

rows = create_rows(files, NUM_COLUMNS)

formatted_rows = format_rows(rows)

formatted_rows.each do |row|
  puts row.compact.join
end
