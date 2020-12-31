$<.binmode
s=$<.read+"\0"*8000
$><<["RIFF",s.size+36,"WAVEfmt ",16,1,1,8000,8000,1,8,"data",s.size,s].pack("A4VA8VvvVVvvA4VA*")
