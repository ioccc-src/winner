#!/usr/bin/perl -n0
s%^ *((\d+\.)+\d+)|/$%print$1||"-","
"%emg;s%^/.+%%ms;for$i(18..75){print/^.{$i}([\d.])/gm,"
"}
