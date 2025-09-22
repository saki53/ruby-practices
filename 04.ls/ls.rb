# frozen_string_literal: true

# !/usr/bin/env ruby

# 行ごとに分割した配列を作成する関数
def create_rows(files, columns_count)
  row_count = files.size.ceildiv(columns_count)
  rows = Array.new(row_count) { [] }
  files.each_with_index do |file, index|
    rows[index % row_count] << file
  end
  rows

  index = 0
  files.each_with_object(Array.new(row_count) { [] }) do |file, rows|
    rows[index % row_count] << file
    index += 1
  end
end

# 各行の要素を横幅を揃えて整形する関数
def format_row(array)
  max_len = array.flatten.map(&:length).max
  array.map do |row|
    row.map do |f|
      f.to_s.ljust(max_len + 1)
    end
  end
end

# メイン処理
files = Dir.glob('*').sort
num_columns = 3

result = create_rows(files, num_columns)

result = format_row(result)

result.each do |row|
  puts row.compact.join
end
