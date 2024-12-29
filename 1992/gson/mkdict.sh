#!/usr/bin/env bash
#
# mkdict.sh - make a dictionary file for IOCCC entry 1992/gson
#
# This OBFUSCATED script was provided by the author.
#

# We disable all warnings from shellcheck(1) because this script was provided by
# the author as an OBFUSCATED SCRIPT and not one to follow best practices.
#
# SC2060 (warning): Quote parameters to tr to prevent glob expansion.
# https://www.shellcheck.net/wiki/SC2060 -- Quote parameters to tr to prevent...
# SC2248 (style): Prefer double quoting even when variables don't contain special characters.
# https://www.shellcheck.net/wiki/SC2248
# SC1001 (info): This \^ will be a regular '^' in this context.
# https://www.shellcheck.net/wiki/SC1001 -- This \^ will be a regular '^' in ...
# SC1087 (error): Use braces when expanding arrays, e.g. ${array[idx]} (or ${var}[.. to quiet).
# https://www.shellcheck.net/wiki/SC1087 -- Use braces when expanding arrays,...
# SC2248 (style): Prefer double quoting even when variables don't contain special characters.
# https://www.shellcheck.net/wiki/SC2248
# SC1001 (info): This \^ will be a regular '^' in this context.
# https://www.shellcheck.net/wiki/SC1001 -- This \^ will be a regular '^' in ...
# SC2248 (style): Prefer double quoting even when variables don't contain special characters.
# https://www.shellcheck.net/wiki/SC2248
# shellcheck disable=SC2060,SC2248,SC1001,SC1087
z=a-z];tr [A-Z\] \[$z|sed s/[\^$z[\^$z*/_/g|tr _ \\012|grep ..|sort -u
