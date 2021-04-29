# purpose: to convert DNA/RNA sequence to RNA/DNA
# 2020-04-15
require_relative "./fasta.rb"

if ARGV.size <2
    puts "usage: ruby fasta_convert.rb <RNA/DNA> file_name\n the first argument is output seq type"
    abort
end

mole_type = ARGV.shift
file_name = ARGV.shift

fp = Fasta_parser.new(file_name)

while ft = fp.next_fasta
    puts ft.header
    if mole_type.match(/RNA/i)
        puts ft.seq.gsub(/T/i, "U")
    elsif mole_type.match(/DNA/i)
        puts ft.seq.gsub(/U/i, "T")
    end
end