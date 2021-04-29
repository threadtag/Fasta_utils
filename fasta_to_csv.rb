require_relative 'fasta.rb'
require 'optparse'

usage = <<-USAGE
ruby fasta_to_csv.rb [option] fasta_file
-F: --FS field seperator, tab is default
-s: --sanitize type, to remove invalid character in the sequence, type should be nu or aa
USAGE

if ARGV.size ==0
    puts usage
    abort
end

delim="\t"
sanitize=""
OptionParser.new do |opts|
	opts.banner = "Usage: ruby csv_to_fasta.rb csf_file"
	opts.on("-F seperator","--FS","Field seperator") do |v|
        if v !=""
            delim=v
        end
    end

    opts.on("-s type","--sanitize","sanitize the sequence") do |type|
        sanitize=type
    end
end.parse!


file_name = ARGV.shift
if file_name.empty?
    puts usage
    abort
end
if !File.exists?(file_name)
    puts "file not found"
    puts usage;
    abort
end

fp=Fasta_parser.new(file_name)
while ft = fp.next_fasta do
    if sanitize=="nu"
        ft.sanitize
    elsif sanitize=="aa"
        ft.sanitize("aa")
    end
    puts ft.header[1..-1]+delim+ft.seq
end

fp.close

