#purpose : to translate the nucleic Acid sequence into the protein sequence

require_relative "fasta.rb"

def translate(seq)
    protein =""
    table=Hash[
        "GCC"=>"A",    "AGT"=>"S",    "TGA"=>"*",    "TGT"=>"C",    "CGA"=>"R",    "ATC"=>"I",
        "AAC"=>"N",    "AGC"=>"S",    "TAC"=>"Y",    "ACA"=>"T",    "TCG"=>"S",    "CCG"=>"P",
        "CTG"=>"L",    "GCA"=>"A",    "GTG"=>"V",    "AAG"=>"K",    "GTT"=>"V",    "CAC"=>"H",
        "AGA"=>"R",    "ACC"=>"T",    "CCA"=>"P",    "TGG"=>"W",    "CTC"=>"L",    "CGC"=>"R",
        "TTG"=>"L",    "TAA"=>"*",    "CAG"=>"Q",    "ACG"=>"T",    "ATG"=>"M",    "AAA"=>"K",
        "GTA"=>"V",    "TAG"=>"*",    "CTT"=>"L",    "GGA"=>"G",    "GTC"=>"V",    "TGC"=>"C",
        "TCA"=>"S",    "ATT"=>"I",    "TAT"=>"Y",    "AAT"=>"N",    "ACT"=>"T",    "CAA"=>"Q",
        "GAC"=>"D",    "GGT"=>"G",    "TCC"=>"S",    "TTT"=>"F",    "AGG"=>"R",    "CGT"=>"R",
        "CGG"=>"R",    "CAT"=>"H",    "ATA"=>"I",    "CCC"=>"P",    "GGG"=>"G",    "TTA"=>"L",
        "GAG"=>"E",    "CTA"=>"L",    "GAT"=>"D",    "TCT"=>"S",    "TTC"=>"F",    "GCG"=>"A",
        "GGC"=>"G",    "GCT"=>"A",    "GAA"=>"E",    "CCT"=>"P"    
    ]
    0.step(seq.size-1, 3) do |i|
        if i+2 < seq.size-1
            needle = seq[i..(i+2)]
        else
            needle = seq[i..-1]
        end
        # puts needle
        if table.has_key?(needle.upcase)
            protein << table[needle.upcase]
        else
            protein << "#"
        end
    end
    return protein
end


if ARGV.size ==0
    puts "usage: ruby fasta_translate.rb file_name"
    abort
end    

file_name = ARGV.shift

file_parser = Fasta_parser.new(file_name)

while fasta=file_parser.next_fasta
    puts fasta.header+"_protein"
    puts translate(fasta.seq)
   
end
