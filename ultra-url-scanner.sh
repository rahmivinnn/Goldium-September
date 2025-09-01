#!/bin/bash

echo "🔥 ULTRA URL SCANNER - HUNTING FOR EGG CHARACTERS!"
echo "=================================================="

# Get current commit
COMMIT=$(git rev-parse --short HEAD)
FULL_COMMIT=$(git rev-parse HEAD)

echo "🎯 Hunting for commit: $COMMIT ($FULL_COMMIT)"
echo ""

# Generate ALL possible URL patterns
PATTERNS=(
    "goldium-september"
    "goldium-september-$COMMIT"
    "goldium-september-git-master"
    "goldium-september-git-deploy-egg-characters-latest"
    "v0-goldium-io-ui-design"
    "v0-goldium-io-ui-design-$COMMIT"
    "v0-goldium-io-ui-design-git-master"
    "goldium-september-latest"
    "goldium-september-production"
    "goldium-september-main"
    "rahmivinnn-goldium-september"
)

SUFFIXES=(
    ".vercel.app"
    "-rahmivinnns-projects.vercel.app"
    "-git-master-rahmivinnns-projects.vercel.app"
    "-git-deploy-egg-characters-latest-rahmivinnns-projects.vercel.app"
)

echo "🌐 Generating and testing URLs..."
echo ""

TOTAL_TESTED=0
WORKING_URLS=()
EGG_VERSION_URLS=()

for pattern in "${PATTERNS[@]}"; do
    for suffix in "${SUFFIXES[@]}"; do
        url="https://${pattern}${suffix}/"
        TOTAL_TESTED=$((TOTAL_TESTED + 1))
        
        printf "%-3d. Testing: %-90s " "$TOTAL_TESTED" "$url"
        
        # Quick test
        status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 8 "$url")
        
        if [ "$status" == "200" ]; then
            echo "✅ WORKING"
            WORKING_URLS+=("$url")
            
            # Check for egg characters in a more detailed way
            content=$(curl -s --max-time 5 "$url" 2>/dev/null)
            
            if echo "$content" | grep -q "deployment-version.txt\|K2\.png\|K4\.png\|K6\.png\|EggNFT\|SplashScreen" 2>/dev/null; then
                echo "    🥚🎉 EGG CHARACTERS FOUND! LATEST VERSION!"
                EGG_VERSION_URLS+=("$url")
            elif echo "$content" | grep -q "GOLDIUM\|goldium" 2>/dev/null; then
                echo "    🟡 Has GOLDIUM but checking version..."
                
                # Check deployment version file
                if curl -s "$url/deployment-version.txt" 2>/dev/null | grep -q "Egg Characters" 2>/dev/null; then
                    echo "    🥚✨ CONFIRMED: Latest egg character version!"
                    EGG_VERSION_URLS+=("$url")
                else
                    echo "    ⚠️  Old version detected"
                fi
            else
                echo "    ❓ Working but unknown content"
            fi
        elif [ "$status" == "404" ]; then
            echo "❌ 404"
        else
            echo "⚠️  $status"
        fi
    done
done

echo ""
echo "🏆 FINAL RESULTS:"
echo "================="
echo "📊 Total URLs tested: $TOTAL_TESTED"
echo "✅ Working URLs: ${#WORKING_URLS[@]}"
echo "🥚 URLs with EGG CHARACTERS: ${#EGG_VERSION_URLS[@]}"

echo ""
if [ ${#EGG_VERSION_URLS[@]} -gt 0 ]; then
    echo "🎉🥚 SUCCESS! EGG CHARACTER VERSION FOUND AT:"
    for url in "${EGG_VERSION_URLS[@]}"; do
        echo "   🌟 $url"
    done
    echo ""
    echo "🎯 YOUR LATEST VERSION IS LIVE! 🎯"
else
    echo "⚠️  No egg character version found yet."
    echo ""
    echo "🔧 Working URLs (but old version):"
    for url in "${WORKING_URLS[@]}"; do
        echo "   • $url"
    done
    
    echo ""
    echo "🚀 NEXT ACTION: Manual Vercel Dashboard Setup Required"
    echo "   1. https://vercel.com/dashboard"
    echo "   2. Update project git connection"
    echo "   3. Redeploy from commit: $COMMIT"
fi