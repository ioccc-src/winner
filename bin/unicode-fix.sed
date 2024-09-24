#!/usr/bin/env sed
#
# bin/unicode-fix.sed - workaround to pre-translate certain JSON /u codes
#
# Until the jstrdecode(1) is fixed so that it properly converts 1 or 2 consecutive
# JSON string \uHexHexHexHex values into the proper binary symbol, we pre-translate
# JSON string \uHexHexHexHex values used in this web site as a workaround to
# avoid the jstrdecode(1) bug. We must do this as it's a more complicated bug
# and we wish to move along with the IOCCC.
#
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - until we have fixed jstrdecode, we must FAKE PARSE IOCCC JSON files       - XXX
# XXX - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - GROSS HACK - XXX
# XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX - XXX
#
# Until this bug is the jparse repo is fixed, we need to avoid
# using \\u[[:xdigit:]]{4} within JSON encoded strings.
#
#   https://github.com/xexyl/jparse/issues/13
#
# The above mentioned bug results in certain tools that are based on the
# jparse repo:
#
#   https://github.com/xexyl/jparse
#
# including code from the mkiocccentry repo's jparse sub-directory:
#
#   https://github.com/ioccc-src/mkiocccentry/tree/master/jparse
#
# We need to avoid using \\u[[:xdigit:]]{4} within JSON encoded strings.
# Sorry (tm Canada :-)).
#
# The following sed script converts known problematic \\u[[:xdigit:]]{4}
# combinations into their RAW character form:
#
#   bin/unicode-fix.sed
#
# Use of that sed script serves as a workaround to avoid to avoid any
# problematic \\u[[:xdigit:]]{4} combinations in JSON encoded strings.
#
# For information on the jstrdecode(1) bug, see:
#
#	https://github.com/xexyl/jparse/issues/13
#
# usage:
#
#	cmd | sed -f bin/unicode-fix.sed
#
#	sed -f bin/unicode-fix.sed file > output
#
#	sed -i -f bin/unicode-fix.sed file
#
# VERSION="1.0 2024-09-23"
#
s/\\u00c4/Ä/g
s/\\u00e1/á/g
s/\\u00eb/ë/g
s/\\u00fd/ý/g
s/\\u0159/ř/g
s/\\u2019/’/g
