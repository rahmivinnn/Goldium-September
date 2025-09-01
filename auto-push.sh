#!/bin/bash

# Auto Push Script untuk Goldium Project
# Script ini akan otomatis menambahkan, commit, dan push perubahan ke GitHub

echo "🚀 Starting Auto Push Process..."

# Check if there are any changes
if git diff-index --quiet HEAD --; then
    echo "✅ No changes detected. Repository is up to date."
    exit 0
fi

# Get current branch name
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Current branch: $CURRENT_BRANCH"

# Add all changes
echo "📝 Adding all changes..."
git add .

# Check if there are staged changes
if git diff-index --quiet --cached HEAD --; then
    echo "⚠️  No staged changes found."
    exit 0
fi

# Create commit with timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
COMMIT_MESSAGE="Auto commit: $TIMESTAMP"

echo "💾 Creating commit: $COMMIT_MESSAGE"
git commit -m "$COMMIT_MESSAGE"

# Push to origin
echo "🌐 Pushing to GitHub..."
git push origin "$CURRENT_BRANCH"

# If current branch is not master, also push to master
if [ "$CURRENT_BRANCH" != "master" ]; then
    echo "🔄 Merging to master branch..."
    git checkout master
    git merge "$CURRENT_BRANCH"
    git push origin master
    git checkout "$CURRENT_BRANCH"
    echo "✅ Changes pushed to both $CURRENT_BRANCH and master"
else
    echo "✅ Changes pushed to master"
fi

echo "🎉 Auto push completed successfully!"
echo "🌍 Your changes will be automatically deployed to Vercel"