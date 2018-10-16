# -*- coding: utf-8 -*-
#
require 'yomi'

class String
  def clean2
    # "[人の...(ひとの)][アドレス]" ⇒ "人の...アドレス"
    gsub(/\[([^\[]*)\([^\)]*\)\]/){ $1 }.gsub(/[\[\]\t,]/,'')
  end

  def clean
    # "[人の...(ひとの)][アドレス]" ⇒ "人のアドレス"
    gsub(/\[([^\[]*)\([^\)]*\)\]/){ $1 }.gsub(/[\[\]\t,]/,'').gsub(/\.\.\./,'')
  end

  def replace_yomi
    # "[人の...(ひとの)][アドレス]" ⇒ "[ひとの][アドレス]"
    gsub(/\[[^\[]*\(([^\)]*)\)\]/){ "[#{$1}]" }
  end
end

# puts "[人の...(ひとの)][アドレス]".replace_yomi.clean.yomi

class FlatIndex
  def initialize(id='0000')
    @id = id
    @key = {}
    @yomi = {}
    @wordyomi = {}
    @done = {}
  end

  def create(listfile, dictfile=nil)
    @dicwords = {}
    if dictfile then
      File.open(dictfile,"r"){ |f|
	f.each { |line|
	  next if line =~ /^[#\s]/
	  word, subst = line.split
	  subst = word if subst == ''
	  @dicwords[word] = subst
	}
      }
    end
    File.open(listfile){ |f|
      f.each { |line|
        next if line =~ /^[#\s]/
        key, str = line.split(/\t+/)
        expand(key,'',str)
      }
    }
  end

  def expand(key,prefix,data)
    @dicwords.keys.each { |w|
      if data =~ /^(\[#{w}\])(.*)$/ then
	r = $2
	expand(key,prefix+'['+w+']',r);
	@dicwords[w].split(/,/).each { |s|
	  expand(key,prefix+'['+s+']',r);
	}
	return
      end
    }
    md = /^(.[^\[]*)(\[.*)$/.match(data)
    if md then
      expand(key,prefix+md[1],md[2])
    else
      permute(key,prefix.to_s+data.to_s) unless @done[prefix.to_s+data.to_s]
      @done[prefix.to_s+data.to_s] = true
    end
  end

  def permute(key,str)
    @key[str.clean] = key

    a = str.split(/\[/)
    len = a.length
    
    (1...len).each{ |i|
      pre = a[0...i].join('[')
      post = '[' + a[i...len].join('[')
      entry = pre.clean + "\t" + post.clean
      @yomi[entry] = post.replace_yomi.clean.yomi_for_sort.sub(/^\s+/,'')
      a[i] =~ /^([^\]]*)\]/
      w = $1
      word = "[#{w}]"
      # @tag[entry] = word.replace_yomi.clean.roma
      @wordyomi[word.clean2] = word.replace_yomi.clean
    }
  end

  def dump()
    divtype = "div1"
    prevyomihead = ""
    id = 0
    y = @yomi.keys.sort { |a,b|
      @yomi[a].upcase <=> @yomi[b].upcase
    }.each { |entry|
      next if entry == ''
      key = @key[entry.clean]
      yomi = @yomi[entry]
      yomi += '　　'
      yomi =~ /^../
      yomihead = $&
      yomiclass = "gray"
      if prevyomihead != yomihead
        yomiclass = "black"
        prevyomihead = yomihead
      end
      
#      puts "#{key}\t#{entry}\t#{yomi}"
      s1, s2 = entry.split(/\t/)
      if s1 == "" then
        s1 = "&nbsp;"
      end
      url = key
      url =~ /cards\/(.*)\/card(.*).html/
      authorid = $1
      workid = $2

      print <<EOF
<div style="float:left;width:60;">
  <b class="#{yomiclass}">#{yomihead}</b>
</div>
<div class="element #{divtype}" id="element#{id}" yomi="#{@yomi[entry].chop}">
  <div class=prefix>#{s1}</div>
  <div class=entry>　　<a href="#{url}">#{s2}</a></div>
</div>
EOF
      divtype = (divtype == 'div1' ? 'div2' : 'div1')
      id += 1
    }
  end
end

if __FILE__ == $0 then
  p = FlatIndex.new
  p.create('quickmlhelp.txt','dict.txt')
  p.dump
end

