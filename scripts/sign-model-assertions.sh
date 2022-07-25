#!/usr/bin/env bash
set -e

if [ $# -eq 0 ]; then
    echo "Specify your snapcraft key to sign the assertion model with"
    exit 1
fi

signing_key=$1

for model_assertion in *.json; do
    snap sign -k "$signing_key" < "$model_assertion" > "${model_assertion%.json}.model"
done
