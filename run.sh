#!/bin/bash
#
# A script to run both the backend and frontend services in separate tabs on macOS.
#
# Usage:
#   ./run.sh

echo "🚀 Starting backend and frontend services..."

# Start the backend in a new Terminal tab
osascript -e 'tell app "Terminal" to do script "cd /Users/okgoogle13/resume-agent/backend && source venv/bin/activate && uvicorn src.main:app --reload --port 8000"'


# Start the frontend on a fixed port (8080) using the generic web-server.
# This prevents it from auto-launching a browser, allowing this script to do it.
osascript -e 'tell app "Terminal" to do script "cd /Users/okgoogle13/resume-agent/frontend && flutter run -d web-server --web-port 8080"'

# Give the servers a moment to start up.
# You might need to increase this delay on a slower machine.
echo "Waiting 10 seconds for servers to initialize..."
sleep 10

echo "✅ Opening web app in your default browser at http://localhost:8080"
open http://localhost:8080