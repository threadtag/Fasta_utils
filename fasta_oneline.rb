# purpose: to remove the new line within the sequence
# usage: ruby fasta_online.rb fasta_file
# 2018-06-20
require_relative "fasta.rb"
filename = ARGV.shift
parser = Fasta_parser.new(filename)

while fasta = parser.next_fasta
	puts fasta.header
	puts fasta.seq
end
parser.fasta_close