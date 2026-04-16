#!/bin/bash
set -e

# Rails のサーバーPIDファイル削除
rm -f /app/tmp/pids/server.pid

exec "$@"
