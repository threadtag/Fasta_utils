# Purpose: to check weather the fasta seqs in a file can match a pattern, if it is output that
# usage: ruby fasta_grep.rb \"pattern\" fasta_file  
require 'optparse'
require_relative "fasta.rb"

usage ="Purpose: to check weather the fasta seqs in a file can match a pattern, if it is output that
usage: ruby fasta_grep.rb [options] file_name
-h pattern: the header to match
-s pattern: the sequence to match
-r : to reverse the output, output the unmatched results
"
option={}
OptionParser.new do |opt|
    opt.banner = usage
    opt.on("-h pattern","--header pattern","headder pattern") do |v|
        option[:header_pattern]=v
    end
    opt.on("-s pattern","--seq pattern","sequence pattern") do |v|
        option[:seq_pattern]=v
    end
    opt.on("-r","--reverse","reverse") do |v|
        option[:reverse]=true
    end
end.parse!

if !option.has_key?(:header_pattern) and !option.has_key?(:seq_pattern)
    puts "-s option or -h option should provided"
    puts usage
    abort
end

if ARGV.size < 1
    puts "file_name  not provided"
    puts usage
    abort
end

fasta_file=ARGV.shift

if !File.exist?(fasta_file)
    puts "fasta_file(#{fasta_file}) do not exist"
    puts usage
    abort
end

fp= Fasta_parser.new(fasta_file)

match_ok=false
while seq=fp.next_fasta
    if option.has_key?(:header_pattern) and option.has_key?(:seq_pattern)
        if seq.seq =~ /#{option[:seq_pattern]}/ and seq.header =~/#{option[:header_pattern]}/
            match_ok=true
        end
    elsif option.has_key?(:header_pattern) and !option.has_key?(:seq_pattern)
        if seq.header =~/#{option[:header_pattern]}/
            match_ok=true
        end
    elsif !option.has_key?(:header_pattern) and option.has_key?(:seq_pattern)
        if seq.seq =~/#{option[:seq_pattern]}/
            match_ok=true
        end 
    end

    if match_ok
            if ! option.has_key?(:reverse)
            puts seq.header
            puts seq.seq
        end
    else
        if option.has_key?(:reverse)
            puts seq.header
            puts seq.seq
        end
    end
    match_ok=false
end