#!/bin/bash

# Start script for Video Analyzer Backend

echo "🚀 Starting Video Analyzer Backend..."
echo ""

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found. Please run ./setup.sh first."
    exit 1
fi

# Activate virtual environment
source venv/bin/activate

# Start the server
echo "📡 Starting Flask server on http://localhost:5000"
echo ""
python app.py


