# -*- coding: utf-8 -*-

origfile = ARGV.shift
includefile = ARGV.shift
exit if !origfile || !includefile

File.open(origfile){ |orig|
  orig.each { |line|
    if line =~ /#{includefile}/ then
      File.open(includefile){ |include|
        include.each { |includeline|
          print includeline
        }
      }
    else
      print line
    end
  }
}


