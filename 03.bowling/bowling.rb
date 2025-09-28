#!/usr/bin/env ruby
# frozen_string_literal: true

ALL_PINS = 10

# スコアの取得
score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |score|
  if score == 'X'
    shots << ALL_PINS
    shots << 0
  else
    shots << score.to_i
  end
end

# フレームの作成
frames = shots.each_slice(2).to_a
frames[9] = frames[9..].flatten.join(',').gsub('10,0', '10').split(',').map(&:to_i)
frames = frames[0..9]

# スコアの計算
points = frames.each_with_index.map do |frame, frame_index|
  frame.sum +
    if frame_index < 9
      if frame[0] == ALL_PINS # strike
        additional_point = frame_index < 8 && frames[frame_index + 1][0] == ALL_PINS ? frames[frame_index + 2][0] : frames[frame_index + 1][1]
        frames[frame_index + 1][0] + additional_point
      elsif frame.sum == ALL_PINS # spare
        frames[frame_index + 1][0]
      else
        0
      end
    else
      0
    end
end

puts points.sum
