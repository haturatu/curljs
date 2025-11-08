#!/bin/bash
# wrapper script for curl.js
export PUPPETEER_CACHE_DIR="/usr/local/lib/curljs/.cache"
exec node "/usr/local/lib/curljs/curl.js" "$@"
