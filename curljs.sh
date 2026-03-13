#!/bin/bash
# wrapper script for curl.js
export PUPPETEER_CACHE_DIR="/usr/local/lib/curljs/.cache"
if [ -z "${PUPPETEER_EXECUTABLE_PATH:-}" ] && [ -f "/usr/local/lib/curljs/browser_path" ]; then
    PUPPETEER_EXECUTABLE_PATH="$(cat /usr/local/lib/curljs/browser_path)"
    export PUPPETEER_EXECUTABLE_PATH
fi
exec node "/usr/local/lib/curljs/curl.js" "$@"
