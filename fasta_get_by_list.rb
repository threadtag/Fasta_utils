#
require "digest"
require_relative "fasta.rb"

if ARGV.size <2
    puts "usage: ruby fasta_get_by_list.rb fasta_file list_file"
    abort
end

fasta_file = ARGV.shift
list_file = ARGV.shift

fasta_hash = {} 
header_array = []

fp = Fasta_parser.new(fasta_file)

while fasta = fp.next_fasta
    header_array << fasta.header
    md5 = Digest::MD5.hexdigest(fasta.header)
    fasta_hash[md5]=fasta
end

def output_seq(s)
    if s.index('.')!=nil
        m=s.match(/^(\w+)(\W+)$/)
        puts m[1]
        puts m[2]
    else
        puts s
    end

end

# p fasta_hash
# p header_array
File.open(list_file) do |f|
    f.each_line do |l|
        if l.chomp==""
            puts ""
            next
        end
        flds = l.chomp.split(',')
        # p flds
        to_report=true
        header_array.each do |h|
            flds.each do |fld|
                if !h.match(/#{fld}/)
                    to_report = false
                    break
                end
            end
            # p to_report
            if to_report
                md5 = Digest::MD5.hexdigest(h)
                ft = fasta_hash[md5]
                puts ft.header
                output_seq(ft.seq)
            end
            to_report=true
        end
    end
end