threads_count = ENV.fetch("RAILS_MAX_THREADS", 3)
threads threads_count, threads_count

# Puma が受け付けるポート番号（Render が PORT を渡す）
port ENV.fetch("PORT", 3000)

# Render で必要：0.0.0.0 で待ち受け
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 3000)}"

# bin/rails restart を使った再起動を許可
plugin :tmp_restart

# Solid Queue を Puma 内で動かす（Rails 8 標準）
plugin :solid_queue if ENV["SOLID_QUEUE_IN_PUMA"]

# PID ファイル（必要な場合のみ）
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]
