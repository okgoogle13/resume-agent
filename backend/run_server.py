#!/usr/bin/env python3
"""
Run server script for the Enhanced Resume Agent backend.

This provides an alternative way to run the server. For development,
the command in `setup.sh` which enables auto-reloading is recommended.
"""
import sys
import os
import uvicorn

from src.main import app

# Add the script's directory to Python's path to ensure 'src' can be found.
# This makes the script runnable from other locations.
script_dir = os.path.dirname(os.path.abspath(__file__))
if script_dir not in sys.path:
    sys.path.insert(0, script_dir)

if __name__ == "__main__":
    print("Starting Enhanced Resume Agent backend server...")
    print("Server will be available at: http://localhost:8000")
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=False)
