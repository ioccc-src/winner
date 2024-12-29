#!/usr/bin/env bash
(>&2 echo "Please be patient. Extracting Italian words")
(>&2 echo "from aspell takes a few minutes.")
set -x
LC_ALL=C ./getwords.sh it | LC_ALL=C grep .. | LC_ALL=C ./prog aàbcdeèéfghiìlmnoòpqrstuùvz #jkwxy
