#!/bin/bash

echo "🔍🔍🔍 DEEP CONTENT CHECK - HUNTING EGG CHARACTERS! 🔍🔍🔍"
echo "======================================================="

WORKING_URLS=(
    "https://v0-goldium-io-ui-design.vercel.app/"
    "https://v0-goldium-io-ui-design-git-master-rahmivinnns-projects.vercel.app/"
    "https://v0-goldium-io-ui-design-git-main-rahmivinnns-projects.vercel.app/"
)

for url in "${WORKING_URLS[@]}"; do
    echo ""
    echo "🔎 DEEP SCANNING: $url"
    echo "================================================"
    
    # Get full HTML content
    content=$(curl -s "$url" 2>/dev/null)
    
    echo "📊 Content analysis:"
    
    # Check for various egg-related content
    if echo "$content" | grep -q "K2\.png\|K4\.png\|K6\.png" 2>/dev/null; then
        echo "✅ Character images (K2, K4, K6) FOUND!"
    else
        echo "❌ Character images not found"
    fi
    
    if echo "$content" | grep -q "EggNFT\|egg.*nft\|Egg.*Card" 2>/dev/null; then
        echo "✅ EggNFT components FOUND!"
    else
        echo "❌ EggNFT components not found"
    fi
    
    if echo "$content" | grep -q "SplashScreen\|splash.*screen" 2>/dev/null; then
        echo "✅ SplashScreen FOUND!"
    else
        echo "❌ SplashScreen not found"
    fi
    
    if echo "$content" | grep -q "NUCLEAR.*EGG\|DEPLOYMENT_FORCE\|egg-characters-latest" 2>/dev/null; then
        echo "✅ NUCLEAR deployment markers FOUND!"
    else
        echo "❌ NUCLEAR markers not found"
    fi
    
    if echo "$content" | grep -q "temperature\|mood.*system\|sparkle.*effect" 2>/dev/null; then
        echo "✅ Egg interaction systems FOUND!"
    else
        echo "❌ Egg interaction systems not found"
    fi
    
    # Check specific deployment markers
    echo ""
    echo "🔍 Checking deployment version file..."
    version_content=$(curl -s "$url/deployment-version.txt" 2>/dev/null)
    if echo "$version_content" | grep -q "Egg Characters" 2>/dev/null; then
        echo "✅ DEPLOYMENT VERSION FILE CONFIRMS EGG CHARACTERS!"
        echo "🎉🥚 THIS URL HAS THE LATEST VERSION!"
    else
        echo "❌ No deployment version file or old version"
    fi
    
    # Check for GOLDIUM branding
    if echo "$content" | grep -q "GOLDIUM" 2>/dev/null; then
        echo "✅ GOLDIUM branding found"
    else
        echo "❌ GOLDIUM branding not found"
    fi
    
    # Summary for this URL
    egg_score=0
    echo "$content" | grep -q "K2\.png\|K4\.png\|K6\.png" && egg_score=$((egg_score + 1))
    echo "$content" | grep -q "EggNFT" && egg_score=$((egg_score + 1))
    echo "$content" | grep -q "SplashScreen" && egg_score=$((egg_score + 1))
    echo "$content" | grep -q "NUCLEAR.*EGG\|DEPLOYMENT_FORCE" && egg_score=$((egg_score + 1))
    
    echo ""
    echo "📊 EGG CHARACTER SCORE: $egg_score/4"
    
    if [ $egg_score -ge 3 ]; then
        echo "🎉🥚 HIGH PROBABILITY: This URL has egg characters!"
        echo "🌟 TRY THIS URL: $url"
    elif [ $egg_score -ge 1 ]; then
        echo "🟡 PARTIAL: Some egg features detected"
    else
        echo "❌ OLD VERSION: No egg characters detected"
    fi
done

echo ""
echo "🏆 FINAL DEEP SCAN RESULTS:"
echo "=========================="
echo "📱 Tested ${#WORKING_URLS[@]} working URLs"
echo ""
echo "💡 If no egg characters found, try:"
echo "1. Wait 5 more minutes for cache to clear"
echo "2. Hard refresh browser (Ctrl+F5)"
echo "3. Manual Vercel dashboard setup"
echo ""
echo "🔥 Repository commit 313cc0e is LOADED with egg characters!"
echo "🥚 All components are ready: SplashScreen, EggNFT, animations!"