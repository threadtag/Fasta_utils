# purpose : generate a random fasta seq
usage ="usage: ruby random_fasta.rb n size\n n:sequence count, size: size of each sequence\n n and size should be number"
if ARGV.size < 1
    puts usage
    abort
end


n=ARGV.shift
size=ARGV.shift

unless n.match(/^\d+$/)
    raise usage
end

unless size.match(/^\d+$/)
    raise usage 
end

bases="ATCG"
alphabet="ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
def get_rand_char(str,cnt)
    r=""
    1.upto(cnt.to_i) do 
        r +=str[rand(str.size)]
    end
    r
end


n.to_i.times do
    print ">"
    puts get_rand_char(alphabet,20)
    puts get_rand_char(bases,size)
end
