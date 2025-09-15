# frozen_string_literal: true

# !/usr/bin/env ruby

# ファイルと列数から配列を作成する関数
def create_file_array(files, num_columns)
  row_num = (files.size / num_columns.to_f).ceil
  array = Array.new(row_num) { [] }
  files.each_with_index do |file, index|
    array[index % row_num] << file
  end
  array
end

# 各行の要素を横幅を揃えて整形する関数
def format_row(array)
  max_len = array.flatten.map(&:length).max
  array.each do |row|
    row.each_with_index do |f, i|
      row[i] = f.to_s.ljust(max_len + 1)
    end
  end
  array
end

# メイン処理
files = Dir.glob('*').sort
num_columns = 3

result = create_file_array(files, num_columns)

result = format_row(result)

result.each do |row|
  puts row.compact.join
end
