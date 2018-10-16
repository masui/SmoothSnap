# Ruby-Listの「これつぐ」氏によるjsortをもとにしている
# http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/18345

class String	
  require "kakasi"
  include Kakasi
  
  require 'jcode'
  $KCODE='EUC'
  
  FROM = 'ァアィイゥウェエォオカガキギクグケゲコ' +
    'ゴサザシジスズセゼソゾタダチヂッツヅテデトド' +
    'ナニヌネノハバパヒビピフブプヘベペホボポ' +
    'マミムメモャヤュユョヨラリルレロヮワヰヱヲンヴ' +
    'ぁぃぅぇぉがぎぐげござじずぜぞだぢっづでど' +
    'ばぱびぴぶぷべぺぼぽゃゅょゎゐゑ'
  TO =   'ああいいううええおおかかききくくけけここ' +
    'ささししすすせせそそたたちちつつつててとと' +
    'なにぬねのはははひひひふふふへへへほほほ' +
    'まみむめもややゆゆよよらりるれろわわいえをんう' +
    'あいうえおかきくけこさしすせそたちつつてと' +
    'ははひひふふへへほほやゆよわいえ'
  
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
  
  def yomi
    kakasi("-oeuc -JH -KH",self)
  end

  def roma
    kakasi("-oeuc -Ja -Ha -Ka",self)
  end
  
  def yomi_for_sort
    yomi.tr(FROM,TO).gsub(/(.)ー/){$1 + vowel($1)}
  end
end

if __FILE__ == $0 then
  a = [
    '会館',
    '歓談',
    'カード',
    '外人',
    '怪人',
    '母さん',
    '快調',
    'ガーベラ',
  ]
  
  a.sort { |a,b|
    a.yomi <=> b.yomi
  }.each { |s|
    puts s
  }
end


