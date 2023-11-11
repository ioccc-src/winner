#!/usr/bin/env bash

make all >/dev/null || exit 1


echo "$ echo 'seeing or feeling is believing' | ./huffman" 1>&2
echo 'seeing or feeling is believing' | ./huffman 2>/dev/null

echo "$ echo 'CC OR NOT CC' | ./huffman" 1>&2
echo 'CC OR NOT CC' | ./huffman 2>/dev/null

echo "$ $ echo 'CC OR NOT CC' | ./huffman | ./huffman" 1>&2
echo 'CC OR NOT CC' | ./huffman 2>/dev/null | ./huffman 2>/dev/null
