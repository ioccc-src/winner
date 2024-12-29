#!/usr/bin/env bash
# 
# Are the umlauts ä, ö, ü and Eszett (ß) letters in the German alphabet? There
# is more than one opinion on the subject but a lot of words do have an umlaut
# (or Umlaut in German). In some (probably all) systems this script outputs
# nothing probably because it's very hard to form a perfect pangram in German,
# if it's not impossible. Nevertheless, we do include the other characters
# whether or not they are in your view considered part of the alphabet for the
# reason that so many words have them.

LC_ALL=C ./getwords.sh de | LC_ALL=C grep .. | LC_ALL=de_DE.UTF-8 ./prog aäbcdefghijklmnoöpqrsßtuüvwxyz
