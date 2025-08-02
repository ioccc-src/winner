#!/usr/bin/env bash

LICENSE_URL="https://od.lk/d/NTJfNDgwODA2NjVf/LLAMA2_LICENSE"
MODEL_LOCATION_URL="https://od.lk/d/NTJfNDgxMDQzMzNf/model_location"

# Step 1: Download and display the license file

wget -q -O LLAMA2_LICENSE "$LICENSE_URL"

cat LLAMA2_LICENSE
echo ""
echo ""
echo "----------------"
echo ""

# Step 2: Ask user to accept the license, then download the model

read -r -p "Accept Meta's license to download the llama2-7b-chat model for use with ChatIOCCC. Type Y to accept: " ACCEPT

if [[ "$ACCEPT" == "Y" || "$ACCEPT" == "y" || "$ACCEPT" == "yes" || "$ACCEPT" == "Yes" || "$ACCEPT" == "YES" ]]; then
    # Step 3: Download the model file
    echo ""
    echo "Downloading model ..."
    rm -f LLAMA2_LICENSE model
    wget -q --show-progress -O model "$(wget -q -O - "$MODEL_LOCATION_URL")"
else
    echo "License not accepted. Exiting."
    exit 1
fi
exit 0
