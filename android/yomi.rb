# -*- coding: utf-8 -*-
#
# MeCabを使って文字列の読みを取得
#
# Ruby-Listの「これつぐ」氏によるjsortをもとにしている
# http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/18345
#

class String
  require 'jcode'
  require "MeCab"
  $KCODE = 'u'
  @@mecab = MeCab::Tagger.new("-Oyomi")  # カタカナの読みを取得

  def katakana
    @@mecab.parse(self)
  end
  
  def hiragana
    katakana.tr('ａ-ｚＡ-Ｚァ-ン０-９','a-zA-Zぁ-ん0-9')
  end

  def yomi
    hiragana
  end
  
  def yomi_for_sort
    from = 'ァアィイゥウェエォオカガキギクグケゲコ' +
      'ゴサザシジスズセゼソゾタダチヂッツヅテデトド' +
      'ナニヌネノハバパヒビピフブプヘベペホボポ' +
      'マミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ' +
      'ぁぃぅぇぉがぎぐげござじずぜぞだぢっづでど' +
      'ばぱびぴぶぷべぺぼぽゃゅょゎゐゑ'
    to = 'ああいいううええおおかかききくくけけここ' +
      'ささししすすせせそそたたちちつつつててとと' +
      'なにぬねのはははひひひふふふへへへほほほ' +
      'まみむめもややゆゆよよらりるれろわわいえをんう' +
      'あいうえおかきくけこさしすせそたちつつてと' +
      'ははひひふふへへほほやゆよわいえ'
    yomi.tr(from,to).gsub(/(.)ー/){$1 + vowel($1)}
  end
  
  def vowel(c)
    case c
    when /[あかさたなはまやらわ]/; 'あ'
    when /[いきしちにひみゐり]/;   'い'
    when /[うくすつぬふむゆる]/;   'う'
    when /[えけせてねへめゑれ]/;   'え'
    when /[おこそとのほもよろを]/; 'お'
    else; 'ー'
    end
  end
end

