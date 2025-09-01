#!/bin/bash

echo "🔍 CHECKING NEW BRANCH DEPLOYMENTS"
echo "=================================="

COMMIT=$(git rev-parse --short HEAD)
echo "🎯 Commit: $COMMIT"
echo ""

# New branch patterns
NEW_URLS=(
    "https://goldium-september-git-main-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-git-production-egg-characters-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-egg-characters.vercel.app/"
    "https://goldium-september-egg-characters-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-egg-characters-git-main-rahmivinnns-projects.vercel.app/"
    "https://v0-goldium-io-ui-design-git-main-rahmivinnns-projects.vercel.app/"
    "https://v0-goldium-io-ui-design-git-production-egg-characters-rahmivinnns-projects.vercel.app/"
)

echo "🌐 Testing new branch deployment URLs..."
echo ""

FOUND_LATEST=false

for url in "${NEW_URLS[@]}"; do
    printf "Testing: %-100s " "$url"
    
    status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url")
    
    if [ "$status" == "200" ]; then
        echo "✅ WORKING"
        
        # Check for latest version
        if curl -s --max-time 5 "$url/deployment-version.txt" 2>/dev/null | grep -q "Egg Characters" 2>/dev/null; then
            echo "    🥚🎉 EGG CHARACTERS VERSION FOUND!"
            echo "    🌟 LATEST VERSION LIVE AT: $url"
            FOUND_LATEST=true
        else
            # Check HTML content for egg references
            content=$(curl -s --max-time 5 "$url" 2>/dev/null)
            if echo "$content" | grep -q "K2\.png\|K4\.png\|K6\.png\|EggNFT" 2>/dev/null; then
                echo "    🥚✨ EGG CHARACTERS DETECTED IN HTML!"
                echo "    🌟 LATEST VERSION LIVE AT: $url"
                FOUND_LATEST=true
            else
                echo "    ⚠️  Working but old version"
            fi
        fi
    elif [ "$status" == "404" ]; then
        echo "❌ 404"
    else
        echo "⚠️  $status"
    fi
done

echo ""
if [ "$FOUND_LATEST" = true ]; then
    echo "🎉🥚 SUCCESS! LATEST EGG CHARACTER VERSION IS LIVE!"
else
    echo "⏳ Still waiting for deployment... Let's wait a bit more and try ultimate strategy!"
fi

echo ""
echo "📱 Current working URLs (might be old):"
echo "   • https://v0-goldium-io-ui-design.vercel.app/"
echo "   • https://v0-goldium-io-ui-design-git-master-rahmivinnns-projects.vercel.app/"