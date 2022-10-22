#!/bin/sh

# Remove a potentially pre-existing server.pid for Rails.
if [ -f /cb-api/tmp/pids/server.pid ]; then
  rm -f /cb-api/tmp/pids/server.pid
fi

bundle exec rails db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
