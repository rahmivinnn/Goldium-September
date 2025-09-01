#!/bin/bash

# Watch and Auto Push Script
# Script ini akan memantau perubahan file dan otomatis push ke GitHub

echo "👀 Starting file watcher for auto push..."
echo "📁 Watching directory: $(pwd)"
echo "🛑 Press Ctrl+C to stop"

# Function to perform auto push
auto_push() {
    echo ""
    echo "🔄 Changes detected! Starting auto push..."
    ./auto-push.sh
    echo "⏰ Waiting for next changes..."
    echo ""
}

# Check if inotify-tools is available
if ! command -v inotifywait &> /dev/null; then
    echo "⚠️  inotify-tools not found. Installing..."
    
    # Try to install inotify-tools
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y inotify-tools
    elif command -v yum &> /dev/null; then
        sudo yum install -y inotify-tools
    elif command -v brew &> /dev/null; then
        brew install inotify-tools
    else
        echo "❌ Cannot install inotify-tools automatically."
        echo "💡 Alternative: Use the manual push script with: ./auto-push.sh"
        exit 1
    fi
fi

# Watch for file changes (excluding .git directory and node_modules)
inotifywait -m -r -e modify,create,delete,move \
    --exclude '(\.git|node_modules|\.next|dist|build)' \
    . | while read path action file; do
    
    # Skip if it's a temporary file or hidden file
    if [[ "$file" =~ ^\. ]] || [[ "$file" =~ ~$ ]] || [[ "$file" =~ \.tmp$ ]]; then
        continue
    fi
    
    echo "📝 File changed: $path$file ($action)"
    
    # Wait a bit to avoid multiple rapid changes
    sleep 2
    
    # Perform auto push
    auto_push
done