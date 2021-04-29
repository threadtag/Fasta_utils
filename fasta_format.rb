# purpose: to format the fasta sequence specified by a width number
# usage: ruby fasta_format.rb -w n fasta_file
# 2018-06-20
require_relative "fasta.rb"
require "optparse"
usage ="usage: ruby fasta_format.rb -w n fasta_file"
option={}
OptionParser.new do |opt|
    opt.banner=usage
    opt.on("-w n", "--width n","width of the sequence block") do |n|
        option[:width]=n
    end
end.parse!

if ARGV.size <1
    puts usage
    abort 
end

filename = ARGV.shift
if !File.exists?(filename)
    puts "file #{filename} not exists"
    puts usage
    abort
end

parser = Fasta_parser.new(filename)
while fasta = parser.next_fasta
    puts fasta.header
    if option.has_key?(:width)
        width = option[:width]
    else
        width ="80"
    end
    seq = fasta.seq.gsub(/(\w{#{width}})/,"\\1\n")
	puts seq
end
parser.fasta_close