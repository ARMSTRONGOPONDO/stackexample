#!/bin/sh
set -e

JS_DIR="/usr/share/nginx/html/js"
mkdir -p "$JS_DIR"

API_BASE_URL_ESC=${API_BASE_URL:-}
STACK_BACKEND_URL_ESC=${STACK_BACKEND_URL:-}

# Default to empty or current origin (frontend will fallback to window.location.origin when empty)
cat > "$JS_DIR/runtime-config.js" <<'EOF'
(function(){
  window.runtimeConfig = window.runtimeConfig || {};
  window.runtimeConfig.API_BASE_URL = "__API_BASE_URL__";
  window.runtimeConfig.STACK_BACKEND_URL = "__STACK_BACKEND_URL__";
})();
EOF

# Replace placeholders safely
if [ -n "$API_BASE_URL_ESC" ]; then
  sed -i "s~__API_BASE_URL__~$API_BASE_URL_ESC~g" "$JS_DIR/runtime-config.js"
else
  sed -i "s~__API_BASE_URL__~~g" "$JS_DIR/runtime-config.js"
fi

if [ -n "$STACK_BACKEND_URL_ESC" ]; then
  sed -i "s~__STACK_BACKEND_URL__~$STACK_BACKEND_URL_ESC~g" "$JS_DIR/runtime-config.js"
else
  sed -i "s~__STACK_BACKEND_URL__~~g" "$JS_DIR/runtime-config.js"
fi

exec nginx -g "daemon off;"
