#!/usr/bin/env bash

BASE="https://piter-cantropus.github.io/cajones-app"

mkdir -p qr

jq -r '.[].nombre' data.json | while read name
do
id=$(echo "$name" | tr 'A-Z' 'a-z' | tr ' ' '-')
url="$BASE/#$id"
qrencode -s 8 -o qr/$id.png "$url"
done

echo "QR generados"
