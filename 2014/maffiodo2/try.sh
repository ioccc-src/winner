#!/usr/bin/env bash
#
# try.sh - demonstrate IOCCC winner 2014/maffiodo2
#

# make sure CC is set so that when we do make CC="$CC" it isn't empty. Doing it
# this way allows us to have the user specify a different compiler in an easy
# way.
if [[ -z "$CC" ]]; then
    CC="cc"
fi

make CC="$CC" all >/dev/null || exit 1

# clear screen after compilation so that only the entry is shown
clear

echo "$ cat image.rgb | ./prog '  .,:;!$#@'" 1>&2
read -r -n 1 -p "Press any key to run command (space = next page, q = quit): "
echo 1>&2
# ^-------^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# shellcheck disable=SC2002
cat image.rgb | ./prog '  .,:;!$#@' | less -EXF

echo "$ cat image.rgb | ./prog '  .:;Y0'" 1>&2
read -r -n 1 -p "Press any key to run command (space = next page, q = quit): "
echo 1>&2
# ^-------^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# shellcheck disable=SC2002
cat image.rgb | ./prog "  .:;Y0" | less -EXF

echo "$ cat image.rgb | ./prog ' :1'" 1>&2
read -r -n 1 -p "Press any key to run command (space = next page, q = quit): "
echo 1>&2
# ^-------^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# shellcheck disable=SC2002
cat image.rgb | ./prog ' :1' | less -EXF

echo "$ cat image.rgb | ./prog '  .:;Y0'" 1>&2
read -r -n 1 -p "Press any key to run command (space = next page, q = quit): "
echo 1>&2
# ^-------^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# shellcheck disable=SC2002
cat image.rgb | ./prog '  .:;Y0' | less -EXF

echo "$ cat image.rgb | ./prog ' .:-=+*#%@'" 1>&2
read -r -n 1 -p "Press any key to run command (space = next page, q = quit): "
echo 1>&2
# ^-------^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# shellcheck disable=SC2002
cat image.rgb | ./prog ' .:-=+*#%@' | less -EXF

echo "$ cat image.rgb | ./prog '   .,:!-iots&8%#@$'" 1>&2
read -r -n 1 -p "Press any key to run command (space = next page, q = quit): "
echo 1>&2
# ^-------^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
# shellcheck disable=SC2002
cat image.rgb | ./prog '   .,:!-iots&8%#@$' | less -EXF
