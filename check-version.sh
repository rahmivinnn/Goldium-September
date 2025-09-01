#!/bin/bash

echo "🔍 Checking if latest version with egg characters is deployed..."

URL="https://v0-goldium-io-ui-design.vercel.app/"

echo "📡 Fetching website content from: $URL"

# Get the HTML content and check for specific elements
content=$(curl -s "$URL")

echo ""
echo "🔎 Checking for key features..."

# Check for SplashScreen component
if echo "$content" | grep -q "SplashScreen\|K2\.png\|K4\.png\|K6\.png"; then
    echo "✅ SplashScreen with character images found"
else
    echo "❌ SplashScreen not found"
fi

# Check for EggNFT components
if echo "$content" | grep -q "EggNFT\|egg.*nft\|magical.*egg"; then
    echo "✅ Egg NFT components found"
else
    echo "❌ Egg NFT components not found"
fi

# Check for Next.js app structure
if echo "$content" | grep -q "_next\|__NEXT_DATA__"; then
    echo "✅ Next.js app detected"
else
    echo "❌ Next.js app not detected"
fi

# Check if it's loading or showing content
if echo "$content" | grep -q "GOLDIUM"; then
    echo "✅ GOLDIUM branding found"
else
    echo "❌ GOLDIUM branding not found"
fi

echo ""
echo "📋 Summary:"
echo "URL: $URL"

if echo "$content" | grep -q "K6\.png\|SplashScreen" && echo "$content" | grep -q "EggNFT"; then
    echo "🎉 SUCCESS: Latest version with egg characters and splashscreen is deployed!"
else
    echo "⚠️  WARNING: This might be an older version"
    echo "💡 The deployment might still be building or cache needs to clear"
fi

echo ""
echo "🔧 If this is not the latest version:"
echo "1. Wait 2-3 minutes for deployment to complete"
echo "2. Clear browser cache"
echo "3. Try hard refresh (Ctrl+F5)"
echo "4. Check Vercel dashboard for deployment status"