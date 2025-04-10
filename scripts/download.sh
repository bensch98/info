#!/bin/bash

# ./download.sh "https://...m3u8"

# check for correct number of arguments
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <download_url>"
  exit 1
fi

# input params
download_url="$1"

# download .m3u8 video
ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$download_url" -c copy download.mp4

