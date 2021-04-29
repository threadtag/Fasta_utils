# purpose: to transform a csv file to a fasta file
# 2020-04-11
# JHY@home

require 'optparse'

usage = <<-USAGE
ruby csv_to_fasta.rb [option] csf_file
-F: field seperator, [\\s,;:|]+ is default
-n: offset of name column
-s: offset of sequence column
USAGE

if ARGV.size ==0
    puts usage
    abort
end

delim='[\s,;:|]+'
name_offset =0
seq_offset=1
OptionParser.new do |opts|
	opts.banner = "Usage: ruby csv_to_fasta.rb csf_file"
	opts.on("-F seperator","--FS","Field seperator") do |v|
        if v !=""
            delim=v
        end

    end
    opts.on("-n offset","--name-offset","Offset of the name column") do |v|
        if v.match(/^\d+$/)
            name_offset = v.to_i
        end
    end
    opts.on("-s offset","--seq-offset","Offset of the sesq column") do |v|
        if v.match(/^\d+$/)
            seq_offset = v.to_i
        end
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

begin
	tf=File.open(file_name)
rescue
	puts "target_file open failed"
    puts "#{usage}"
    abort
end

tf.each do |line|
    m=line.chomp.split(/#{delim}/)
    if m.size >name_offset.to_i
        puts ">#{m[name_offset]}"
        puts "#{m[seq_offset]}"
    else
        puts ">this line not converted"
        puts line        
    end
end

tf.close






    