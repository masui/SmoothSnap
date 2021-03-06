# -*- coding: utf-8 -*-
#
# 青空文庫のCSVをFlatindex用テキストに変換
# http://www.aozora.gr.jp/index_pages/list_person_all.zip
# CSVはUTF8にしておく。
#

require 'jcode'
$KCODE = 'u'

ARGF.each { |line|
  line.chomp!
  a = line.split(/,/)
  authorid = a[0]
  next if authorid !~ /^\d/
  a[1] =~ /^"(.*)"$/
  author = $1
  sei,mei = author.split(/[\s+]/)
  workid = a[2]
  workid.sub!(/^0+/,'') # 先頭のゼロを消す
  a[3] =~ /^"(.*)"$/
  title = $1
  title.sub!(/^\s+/,'') # 先頭に空白が入っていることがあるので
  t = "[#{title}]"
  if title =~ /^([「『"〔])(.*)$/ then
    t = "#{$1}[#{$2}]"
  end
  puts "http://www.aozora.gr.jp/cards/#{authorid}/card#{workid}.html\t[#{sei}] [#{mei}] #{t}"
}




