# purpose: to replace certain sequence pattern with other bases
# 2020-04-15
require_relative "./fasta.rb"

if ARGV.size <3
    puts "ruby fasta_replace.rb file_name pattern replacement"
    abort
end

file_name = ARGV.shift
pattern = ARGV.shift
replacement =ARGV.shift

fp = Fasta_parser.new(file_name)

while ft = fp.next_fasta
    puts ft.header
    puts ft.seq.gsub(/#{pattern}/, replacement)
end