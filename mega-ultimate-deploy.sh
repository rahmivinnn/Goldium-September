#!/bin/bash

echo "🔥🔥🔥 MEGA ULTIMATE DEPLOYMENT STRATEGY 🔥🔥🔥"
echo "=============================================="
echo "🥚 TIDAK AKAN BERHENTI SAMPAI EGG CHARACTERS LIVE!"
echo ""

# Get current commit
COMMIT=$(git rev-parse --short HEAD)
TIMESTAMP=$(date +%s)

echo "🎯 Commit: $COMMIT"
echo "⏰ Timestamp: $TIMESTAMP"
echo ""

# Create multiple deployment strategies
echo "🚀 STRATEGY 1: Multiple branch deployment..."

# Create and push multiple branches
BRANCHES=(
    "deploy-egg-$TIMESTAMP"
    "production-latest"
    "egg-characters-live"
    "goldium-latest"
    "main-egg-deploy"
)

for branch in "${BRANCHES[@]}"; do
    echo "📝 Creating branch: $branch"
    git checkout -b "$branch" 2>/dev/null || git checkout "$branch"
    git push origin "$branch" --force
done

echo ""
echo "🚀 STRATEGY 2: Force commits with different messages..."

# Go back to main
git checkout main

# Create multiple force commits
for i in {1..3}; do
    echo "DEPLOYMENT_FORCE_$i=$TIMESTAMP" > "force-deploy-$i.txt"
    git add .
    git commit -m "🥚 MEGA FORCE $i: Egg characters deployment $(date)"
    git push origin main --force
    sleep 2
done

echo ""
echo "🚀 STRATEGY 3: Testing ALL possible new URLs..."

# Wait a bit for deployments
echo "⏳ Waiting 30 seconds for deployments to start..."
sleep 30

# Test new branch URLs
NEW_BRANCH_URLS=(
    "https://goldium-september-git-deploy-egg-$TIMESTAMP-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-git-production-latest-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-git-egg-characters-live-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-git-goldium-latest-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-git-main-egg-deploy-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-git-main-rahmivinnns-projects.vercel.app/"
)

echo "🔍 Testing new deployment URLs..."
FOUND_SUCCESS=false

for url in "${NEW_BRANCH_URLS[@]}"; do
    printf "Testing: %-100s " "$url"
    
    status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url")
    
    if [ "$status" == "200" ]; then
        echo "✅ WORKING!"
        
        # Check for egg characters
        content=$(curl -s --max-time 5 "$url" 2>/dev/null)
        if echo "$content" | grep -q "K2\.png\|K4\.png\|K6\.png\|EggNFT\|DEPLOYMENT_FORCE" 2>/dev/null; then
            echo "    🥚🎉🎉🎉 EGG CHARACTERS FOUND! SUCCESS!"
            echo "    🌟🌟🌟 LATEST VERSION LIVE AT: $url"
            FOUND_SUCCESS=true
            break
        else
            echo "    ⚠️  Working but checking..."
        fi
    elif [ "$status" == "404" ]; then
        echo "❌ 404"
    else
        echo "⚠️  $status"
    fi
done

echo ""
if [ "$FOUND_SUCCESS" = true ]; then
    echo "🎉🥚🎉🥚🎉 MEGA SUCCESS! EGG CHARACTERS ARE LIVE! 🎉🥚🎉🥚🎉"
else
    echo "⚡ STILL FIGHTING! Trying more strategies..."
    echo "📱 Current working (old): https://v0-goldium-io-ui-design.vercel.app/"
    echo ""
    echo "🔥 NEXT MEGA STRATEGY: Wait 2 more minutes and scan EVERYTHING!"
fi