# Ruby-List�Ρ֤���Ĥ��׻�ˤ��jsort���Ȥˤ��Ƥ���
# http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/18345

class String	
  require "kakasi"
  include Kakasi
  
  require 'jcode'
  $KCODE='EUC'
  
  FROM = '��������������������������������������' +
    '�����������������������������¥åĥťƥǥȥ�' +
    '�ʥ˥̥ͥΥϥХѥҥӥԥե֥ץإ٥ڥۥܥ�' +
    '�ޥߥ���������������������' +
    '���������������������������������¤äŤǤ�' +
    '�ФѤӤԤ֤פ٤ڤܤݤ������'
  TO =   '����������������������������������������' +
    '�����������������������������ĤĤĤƤƤȤ�' +
    '�ʤˤ̤ͤΤϤϤϤҤҤҤդդդؤؤؤۤۤ�' +
    '�ޤߤ���������������襤�����' +
    '�����������������������������������ĤĤƤ�' +
    '�ϤϤҤҤդդؤؤۤۤ���襤��'
  
  def vowel(c)
    case c
    when /[���������ʤϤޤ���]/; '��'
    when /[���������ˤҤߤ��]/;   '��'
    when /[�������Ĥ̤դ���]/;   '��'
    when /[�������Ƥͤؤ���]/;   '��'
    when /[�������ȤΤۤ����]/; '��'
    else; '��'
    end
  end
  
  def yomi
    kakasi("-oeuc -JH -KH",self)
  end

  def roma
    kakasi("-oeuc -Ja -Ha -Ka",self)
  end
  
  def yomi_for_sort
    yomi.tr(FROM,TO).gsub(/(.)��/){$1 + vowel($1)}
  end
end

if __FILE__ == $0 then
  a = [
    '���',
    '����',
    '������',
    '����',
    '����',
    '�줵��',
    '��Ĵ',
    '�����٥�',
  ]
  
  a.sort { |a,b|
    a.yomi <=> b.yomi
  }.each { |s|
    puts s
  }
end


