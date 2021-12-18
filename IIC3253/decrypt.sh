#!/bin/bash

# Usage
# First, place decrypt.sh **in the same folder** as all the encrypted files *.zip.enc
# Then, make sure to chmod +x ./decrypt.sh
# Finally, run it as ./decrypt.sh your_key
# The file `nota.zip` will contain your grades :)

KEY=$1

for fname in *
do
    openssl aes-256-cbc -d -a -pbkdf2 -in $fname -out nota.zip -k "$KEY"
    if [ $? -eq 0 ]; then exit 0; fi
done
