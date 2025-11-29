#!/bin/bash

# Setup script for Video Analyzer Backend

echo "🚀 Setting up Video Analyzer Backend..."
echo ""

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.8 or higher."
    exit 1
fi

echo "✓ Python found: $(python3 --version)"

# Create virtual environment
echo ""
echo "📦 Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo ""
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install dependencies
echo ""
echo "📥 Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Setup environment files
echo ""
echo "🔧 Setting up environment files..."
if [ ! -f .env ]; then
    echo "Creating .env from env.example..."
    cp env.example .env
    echo "✓ .env created"
else
    echo "✓ .env already exists"
fi

if [ ! -f .secrets ]; then
    echo "Creating .secrets from secrets.example..."
    cp secrets.example .secrets
    echo "✓ .secrets created"
else
    echo "✓ .secrets already exists"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "📝 Environment files:"
echo "  - .env (configuration)"
echo "  - .secrets (sensitive data)"
echo ""
echo "To start the backend server:"
echo "  1. Activate the virtual environment: source venv/bin/activate"
echo "  2. Run the server: python app.py"
echo ""
echo "Or simply run: ./start.sh"

