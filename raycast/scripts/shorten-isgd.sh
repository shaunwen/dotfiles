#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Shorten URL with is.gd
# @raycast.mode silent
# @raycast.packageName URL Shortener
# @raycast.icon 🔗
# @raycast.description Shorten the URL on the clipboard with is.gd and copy the short link

url=$(pbpaste)

if [[ ! "$url" =~ ^https?:// ]]; then
  echo "Clipboard is not a URL"
  exit 1
fi

if ! response=$(curl -sS --max-time 10 --get "https://is.gd/create.php" \
  --data-urlencode "format=simple" \
  --data-urlencode "url=$url"); then
  echo "Could not reach is.gd"
  exit 1
fi

if [[ ! "$response" =~ ^https://is\.gd/ ]]; then
  echo "is.gd: ${response#Error: }"
  exit 1
fi

printf '%s' "$response" | pbcopy
echo "Copied $response"
