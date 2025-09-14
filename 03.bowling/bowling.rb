#!/usr/bin/env ruby
# frozen_string_literal: true

# スコアの取得
score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |score|
  if score == 'X'
    shots << 10
    shots << 0
  else
    shots << score.to_i
  end
end

# フレームの作成
frames = shots.each_slice(2).to_a
frames[9] += frames[10] if frames[10]
frames[9] += frames[11] if frames[11]
frames[9] = frames[9].join(',').gsub('10,0', '10').split(',').map(&:to_i)

frames = frames[0..9]

# スコアの計算
points = frames.each_with_index.map do |frame, frame_index|
  # 1~8フレーム目
  if frame_index < 8
    if frame[0] == 10 # strike
      frame.sum + frames[frame_index + 1][0] + (frames[frame_index + 1][0] == 10 ? frames[frame_index + 2][0] : frames[frame_index + 1][1])
    elsif frame.sum == 10 # spare
      frame.sum + frames[frame_index + 1][0]
    else
      frame.sum
    end
  # 9フレーム目
  elsif frame_index == 8
    if frame[0] == 10 # strike
      frame.sum + frames[frame_index + 1][0] + frames[frame_index + 1][1]
    elsif frame.sum == 10 # spare
      frame.sum + frames[frame_index + 1][0]
    else
      frame.sum
    end
  # 10フレーム目
  else
    frame.sum
  end
end
puts points.sum
