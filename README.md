# Fasta_utils
These are some simple fasta file handling ruby script
## The library file "fasta.rb" contains some classes and common functions
### classes
1. Fasta_seq class
2. Fasta_collection
3. Fasta_parser
5. Fastae
4. Fastae_parser

### functions
1. reverse_complement(seq)
2. is_complement?(x,y,allow_wobble=false)
3. is_wobble?(a,b)
4. is_paired?(u,v,allow_wobble=true)
5. count_GC(s)
6. max_complementary(x,y)

### How to parse a fasta file?
```ruby
require_relative("fasta.rb")
fp = Fasta_parser.new(file_name)
while fasta = fp.next_fasta
    puts fasta.header
    puts fasta.seq
end
fp.close
```
### What is the Fastae format?
Fastae stands for Fasta_extension, sometime when processing sequence some temperary information needs to be stored together with the fasta, but we don't want touch the header part, so just add a note below the header. Example:
```
>seq1
# this is the additional information
ATCGACGACACACACAAACG
```
in the Fastae is subclass of Fasta, its note information can be accessed by ```.note``` method. Example:
```ruby
fp = Fastae_parser.new(file_name) 
while fastae = fp.next_fasta
    puts fastae.header
    puts fastae.note
end
fp.close
```

### how to use Fasta_collection class
A Fasta_collection object is just like an array of Fasta_seq object, but it did a little more, it holds a hash of header string for quick accessing Fasta_seq object. This could only be useful when each header of Fasta_seq object is unique.Example:
```ruby
collection = Fasta_collection(file)
collection.load!
seq1=collection.get(">sequence1")
collection.add(seq2)
puts collection.size
fasta_array=collection.find{|ft|
    ft.header.match(/headerfeature/)    
}
```

## Some command-line scripts
1. Converting Sequences
>ruby fasta_convert.rb mol_type file_name
> #mol_type: DNA or RNA

2. Finding pattern
>ruby fasta_grep.rb [options] file_name
>-h pattern: the header to match
>-s pattern: the sequence to match
>-r : to reverse the output, output the unmatched results

3. Replace sequence
> ruby fasta_replace.rb file_name pattern replacement

4. Wrapping sequence 
>ruby fasta_format.rb -w n fasta_file > output.fasta
>-w n: width of each line

5. Remove sequece wraps
>ruby fasta_oneline.rb input_fasta > output.fasta

6. Fasta to CSV file conversion
>ruby fasta_to_csv.rb [option] fasta_file
>-F: --FS field seperator, tab is default
>-s: --sanitize type, to remove invalid character in the sequence, >type should be nu or aa

7. CSV to Fasta file conversion
>ruby csv_to_fasta.rb [option] csf_file
>-F: field seperator, [\s,:;|]+ is default
>-n: offset of name column
>-s: offset of sequence column

8. Generate random fasta sequences
>ruby random_fasta.rb n size
> n: sequence count, size: size of each sequence
> n and size should be number

9. Index big fasta file 
> ruby fasta_index.rb fasta_file
> seq1:0:469:3:60
>  sequence_name : record_start : recodr_stop : sequence_start : seq_line_width
