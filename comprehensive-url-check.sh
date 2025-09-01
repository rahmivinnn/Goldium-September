#!/bin/bash

echo "🔍 COMPREHENSIVE VERCEL URL CHECK"
echo "================================="
echo "🎯 Looking for latest egg character version..."
echo ""

# Get latest commit hash
COMMIT_HASH=$(git rev-parse --short HEAD)
echo "📝 Latest commit: $COMMIT_HASH"
echo ""

# All possible URL patterns for Vercel
URLS=(
    "https://goldium-september.vercel.app/"
    "https://goldium-september-$COMMIT_HASH.vercel.app/"
    "https://goldium-september-git-master-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-git-deploy-egg-characters-latest-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-latest.vercel.app/"
    "https://v0-goldium-io-ui-design.vercel.app/"
    "https://v0-goldium-io-ui-design-git-master-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-46c600c.vercel.app/"
    "https://goldium-september-8bf9ff2.vercel.app/"
)

echo "🌐 Testing ${#URLS[@]} possible URLs..."
echo ""

WORKING_URLS=()
LATEST_VERSION_URLS=()

for url in "${URLS[@]}"; do
    printf "Testing: %-80s " "$url"
    
    # Get HTTP status
    status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url")
    
    if [ "$status" == "200" ]; then
        echo "✅ WORKING"
        WORKING_URLS+=("$url")
        
        # Check if it has latest version marker
        if curl -s --max-time 5 "$url/deployment-version.txt" 2>/dev/null | grep -q "Egg Characters" 2>/dev/null; then
            echo "    🥚 HAS EGG CHARACTERS - LATEST VERSION!"
            LATEST_VERSION_URLS+=("$url")
        else
            echo "    ⚠️  Working but might be old version"
        fi
    elif [ "$status" == "404" ]; then
        echo "❌ 404"
    else
        echo "⚠️  Status: $status"
    fi
done

echo ""
echo "📊 RESULTS SUMMARY:"
echo "==================="

if [ ${#WORKING_URLS[@]} -eq 0 ]; then
    echo "❌ No working URLs found"
else
    echo "✅ Working URLs found: ${#WORKING_URLS[@]}"
    for url in "${WORKING_URLS[@]}"; do
        echo "   • $url"
    done
fi

echo ""

if [ ${#LATEST_VERSION_URLS[@]} -eq 0 ]; then
    echo "⚠️  No URLs with latest egg character version found"
    echo ""
    echo "🔧 NEXT STEPS:"
    echo "1. Go to https://vercel.com/dashboard"
    echo "2. Find project 'v0-goldium-io-ui-design'"
    echo "3. Update Git repository connection to latest commit"
    echo "4. Or create new project 'goldium-september'"
    echo "5. Deploy from master branch (commit: $COMMIT_HASH)"
else
    echo "🎉 URLs with LATEST egg character version:"
    for url in "${LATEST_VERSION_URLS[@]}"; do
        echo "   🥚 $url"
    done
fi

echo ""
echo "📱 Repository status: Latest egg character version ready in master branch"
echo "🚀 Commit hash: $COMMIT_HASH"