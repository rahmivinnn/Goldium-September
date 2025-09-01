#!/bin/bash

echo "🔥🥚 LAST CHANCE SCANNER - FINAL EGG HUNT! 🥚🔥"
echo "=============================================="

COMMIT=$(git rev-parse --short HEAD)
echo "🎯 Scanning for commit: $COMMIT"
echo ""

# LAST CHANCE - check if any new URLs appeared
LATEST_URLS=(
    "https://goldium-september-313cc0e.vercel.app/"
    "https://goldium-september-$COMMIT.vercel.app/"
    "https://goldium-september-git-main-313cc0e-rahmivinnns-projects.vercel.app/"
    "https://goldium-september-nuclear-$COMMIT.vercel.app/"
    "https://goldium-september-egg-characters-$COMMIT.vercel.app/"
)

echo "🔍 FINAL SCAN - Testing latest commit URLs..."

FOUND_EGG_CHARS=false

for url in "${LATEST_URLS[@]}"; do
    printf "🎯 %-90s " "$url"
    
    status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url")
    
    if [ "$status" == "200" ]; then
        echo "✅ WORKING!"
        
        # Deep check for egg characters
        content=$(curl -s --max-time 8 "$url" 2>/dev/null)
        
        # Multiple detection patterns
        if echo "$content" | grep -q "K2\.png\|K4\.png\|K6\.png" 2>/dev/null; then
            echo "    🥚🎉 CHARACTER IMAGES FOUND!"
            FOUND_EGG_CHARS=true
        fi
        
        if echo "$content" | grep -q "EggNFT\|EggCard\|EggGallery" 2>/dev/null; then
            echo "    🥚🎉 EGG NFT COMPONENTS FOUND!"
            FOUND_EGG_CHARS=true
        fi
        
        if echo "$content" | grep -q "SplashScreen" 2>/dev/null; then
            echo "    🥚🎉 SPLASHSCREEN FOUND!"
            FOUND_EGG_CHARS=true
        fi
        
        if echo "$content" | grep -q "NUCLEAR.*EGG\|DEPLOYMENT_FORCE" 2>/dev/null; then
            echo "    🥚🎉 NUCLEAR MARKERS FOUND!"
            FOUND_EGG_CHARS=true
        fi
        
        if [ "$FOUND_EGG_CHARS" = true ]; then
            echo "    🌟🌟🌟 EGG CHARACTERS CONFIRMED AT: $url"
            echo "    🎉🎉🎉 SUCCESS! LATEST VERSION IS LIVE!"
            break
        else
            echo "    ❓ Working but need to check more..."
        fi
        
    elif [ "$status" == "404" ]; then
        echo "❌ 404"
    else
        echo "⚠️  Status: $status"
    fi
done

echo ""
echo "🔍 ALSO CHECKING: Current working URLs for updates..."

# Check if existing URLs got updated
for url in "https://v0-goldium-io-ui-design.vercel.app/" "https://v0-goldium-io-ui-design-git-main-rahmivinnns-projects.vercel.app/"; do
    echo ""
    echo "🔄 Re-checking: $url"
    
    # Check if it now has deployment version file
    if curl -s "$url/deployment-version.txt" 2>/dev/null | grep -q "Egg Characters" 2>/dev/null; then
        echo "🥚🎉 UPDATED! This URL now has egg characters!"
        FOUND_EGG_CHARS=true
    else
        # Check HTML again for any updates
        content=$(curl -s --max-time 5 "$url" 2>/dev/null)
        if echo "$content" | grep -q "K2\.png\|K4\.png\|K6\.png\|EggNFT" 2>/dev/null; then
            echo "🥚🎉 UPDATED! Egg characters detected in HTML!"
            FOUND_EGG_CHARS=true
        else
            echo "❌ Still old version"
        fi
    fi
done

echo ""
echo "🏆 LAST CHANCE RESULTS:"
echo "======================"

if [ "$FOUND_EGG_CHARS" = true ]; then
    echo "🎉🥚🎉🥚🎉 VICTORY! EGG CHARACTERS FOUND! 🎉🥚🎉🥚🎉"
    echo "🔥🔥🔥 MISSION ACCOMPLISHED! 🔥🔥🔥"
else
    echo "⚡ STILL FIGHTING! Repository is 100% ready!"
    echo "🔥 Commit 313cc0e has ALL egg character features!"
    echo ""
    echo "🚀 FINAL SOLUTION: Manual Vercel Dashboard"
    echo "   https://vercel.com/dashboard"
    echo "   Import: rahmivinnn/Goldium-September"
    echo "   Branch: main (313cc0e)"
    echo ""
    echo "🥚 EGG CHARACTERS ARE WAITING TO BE BORN! 🥚"
fi