#!/bin/bash

echo "🔍 Checking Vercel Deployment Status..."

# Possible URLs to check
URLS=(
    "https://goldium-september.vercel.app/"
    "https://goldium-september-git-master-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-rahmivinnns-projects.vercel.app/"
    "https://v0-goldium-io-ui-design.vercel.app/"
    "https://v0-goldium-io-ui-design-rahmivinnns-projects.vercel.app/"
)

echo "📡 Testing possible deployment URLs..."

for url in "${URLS[@]}"; do
    echo ""
    echo "Testing: $url"
    
    # Get HTTP status code
    status_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    
    if [ "$status_code" == "200" ]; then
        echo "✅ SUCCESS: $url is working (Status: $status_code)"
        echo "🎉 Your site is live at: $url"
        break
    elif [ "$status_code" == "404" ]; then
        echo "❌ 404 NOT FOUND: $url"
    else
        echo "⚠️  Status $status_code: $url"
    fi
done

echo ""
echo "💡 If none work, the deployment might still be building..."
echo "⏰ Wait 2-3 minutes and try again"
echo ""
echo "🔧 Alternative solutions:"
echo "1. Check Vercel dashboard: https://vercel.com/dashboard"
echo "2. Redeploy from Vercel dashboard"
echo "3. Connect repository again in Vercel"