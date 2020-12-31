#!/bin/sh
(>&2 echo "Please be patient. Extracting Italian words")
(>&2 echo "from aspell takes a few minutes.")
set -x
./getwords.sh it | grep .. | ./prog aàbcdeèéfghiìlmnoòpqrstuùvz #jkwxy
