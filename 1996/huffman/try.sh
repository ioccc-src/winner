#!/usr/bin/env bash
#
# try.sh - show IOCCC entry 1996/huffman
#
#   ...
#
#   Well the wolf-man fell dead
#   As you can plainly see
#   And that's the end the story for you and me
#   You still give a listen, you just may
#   Hear a big wolf-man or little piggy say
#   Little pig, little pig, let me in
#   Not by the hair of my chinny, chin, chin
#   Little pig, little pig, let me in
#   Not by the hair of my chinny, chin, chin
#   Well I'm huffin', I'm puffin'
#   I'll blow your house in
#   Huffin', puffin', blow your house in
#   Huffin', puffin', blow your house in
#   Huffin', puffin', blow your house in
#   Huffin' and a puffin' and
#   I'll blow your house in!
#   Huffin' and a puffin' and
#   I'll blow your house in!
#   Huffin' and a puffin' and
#   I'll blow your house in!
#   Huffin' and a puffin' and
#   I'll blow your house in!
# 
#   And the moral of the story is that
#   bands with no talent can easily amuse
#   Idiots with a stupid puppet show.
#
# :-)

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

read -r -n 1 -p "Press any key to run: echo 'seeing or feeling is believing' | ./huffman: "
echo 1>&2
echo 'seeing or feeling is believing' | ./huffman 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'CC OR NOT CC' | ./huffman: "
echo 1>&2
echo 'CC OR NOT CC' | ./huffman 2>/dev/null
echo 1>&2

read -r -n 1 -p "Press any key to run: echo 'CC OR NOT CC' | ./huffman | ./huffman: "
echo 1>&2
echo 'CC OR NOT CC' | ./huffman 2>/dev/null | ./huffman 2>/dev/null
