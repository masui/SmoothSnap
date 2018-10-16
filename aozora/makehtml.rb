require 'flatindex'

text = ARGV.shift
dict = ARGV.shift

p = FlatIndex.new
p.create(text,dict)
p.dump
