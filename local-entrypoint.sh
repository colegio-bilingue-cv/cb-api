#!/bin/sh

# Remove a potentially pre-existing server.pid for Rails.
if [ -f /opt/app/tmp/pids/server.pid ]; then
  rm -f /opt/app/tmp/pids/server.pid
fi

bundle check || \
  bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
