#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require 'net/http'
require 'cgi'

cgi = CGI.new("html3")

id = cgi.params['id'][0].to_s
id =~ /^(.*)_(.*)$/

authorid = $1
workid = $2

# authorid = "000129"
# workid = "043030"
workid.sub!(/^0+/,'') # 先頭のゼロを消す

site = "mirror.aozora.gr.jp"
path = "/cards/#{authorid}/card#{workid}.html"
zipfile = nil

Net::HTTP.version_1_2   # おまじない
Net::HTTP.start(site, 80) {|http|
  response = http.get(path)
  response.body.each { |line|
    if line =~ /files\/(.*\.zip)"/ then
      zipfile = $1
    end
  }
}

zipurl = "http://www.aozora.gr.jp/cards/#{authorid}/files/#{zipfile}"

system "wget #{zipurl} -O junk.zip"
system "unzip junk.zip > junk.log"

textfile = nil
File.open("junk.log"){ |f|
  f.each { |line|
    if line =~ /inflating: (.*\.txt)/ then
      textfile = $1
    end
  }
}

text = File.read(textfile)

system "/bin/rm -f #{textfile}"
system "/bin/rm -f junk.zip junk.log"

cgi.out {
  text
}






