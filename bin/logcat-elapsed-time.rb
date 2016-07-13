#!/usr/bin/env ruby
#
# Android の logcat 出力のタイムスタンプを経過時間に変換するスクリプト
#
# Logcat ログ内の '07-11 21:59:30.567' といった日時表示を
# 先頭の日時からの経過秒数表示 'x.xxx' に変換して表示します。
#
# 使い方:
#   $ ruby logcat-elapsed-time.rb <logcat.txt>
#
# [2016-07-12] Masatoshi Ohta
#
require 'time'  # for Time.parse

# Avoid invalid byte sequence error when calling String#sub
Encoding.default_external = 'utf-8'

TIME_PATTERN = /\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d(\d\d\d)?/
base_time = nil

while line = ARGF.gets
  line.sub!(TIME_PATTERN) do |time_str|
    t = Time.parse(time_str)
    base_time = t unless base_time
    printf('%.3f', t - base_time)
  end
  print line
end

