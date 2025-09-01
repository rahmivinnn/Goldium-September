#!/bin/bash

echo "🚀 FORCE VERCEL DEPLOYMENT - LATEST EGG CHARACTER VERSION"
echo "=========================================================="

# Create a unique deployment trigger
TIMESTAMP=$(date +%s)
echo "⏰ Deployment timestamp: $TIMESTAMP"

# Create a deployment trigger file
echo "Creating deployment trigger..."
echo "DEPLOY_TRIGGER=$TIMESTAMP" > .env.local
echo "LATEST_VERSION=egg-characters-splashscreen" >> .env.local
echo "COMMIT_HASH=$(git rev-parse HEAD)" >> .env.local

# Add to git
git add .env.local

# Force commit with unique message
git commit -m "FORCE DEPLOY $TIMESTAMP: Latest egg character version with splashscreen"

# Push to trigger deployment
echo "🌐 Pushing to GitHub..."
git push origin master

echo ""
echo "⏳ Waiting for deployment to start..."
sleep 10

# Check multiple possible URLs
echo "🔍 Checking deployment URLs..."

URLS=(
    "https://goldium-september.vercel.app/"
    "https://goldium-september-8bf9ff2.vercel.app/"
    "https://goldium-september-git-master-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-latest.vercel.app/"
)

for url in "${URLS[@]}"; do
    echo "Testing: $url"
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    if [ "$status" == "200" ]; then
        echo "✅ SUCCESS: $url is working!"
        
        # Check if it has the latest version
        if curl -s "$url/deployment-version.txt" | grep -q "Egg Characters"; then
            echo "🎉 LATEST VERSION CONFIRMED: This URL has egg characters!"
            echo "🌟 Your site is live with latest version at: $url"
            break
        else
            echo "⚠️  This URL is working but might be old version"
        fi
    else
        echo "❌ Status $status: $url"
    fi
    echo ""
done

echo ""
echo "🎯 If none of the URLs work with latest version:"
echo "1. Go to https://vercel.com/dashboard"
echo "2. Import 'rahmivinnn/Goldium-September' as new project"
echo "3. Name it 'goldium-september'"
echo "4. Deploy from master branch"
echo ""
echo "📱 Current working URL (old version): https://v0-goldium-io-ui-design.vercel.app/"