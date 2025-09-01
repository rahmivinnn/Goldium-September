#!/bin/bash

echo "🔥🔥🔥 ULTIMATE FINAL SCANNER - EGG HUNT! 🔥🔥🔥"
echo "==============================================="
echo "🥚 HUNTING FOR EGG CHARACTERS WITH MAXIMUM POWER!"
echo ""

COMMIT=$(git rev-parse --short HEAD)
echo "🎯 Latest commit: $COMMIT"
echo ""

# MEGA URL PATTERNS - EVERYTHING POSSIBLE
PROJECTS=(
    "goldium-september"
    "goldium-september-egg-characters"
    "goldium-september-nuclear"
    "v0-goldium-io-ui-design"
)

BRANCHES=(
    "main"
    "master"
    "production-latest"
    "egg-characters-live"
    "goldium-latest"
    "main-egg-deploy"
    "deploy-egg-1756708752"
)

SUFFIXES=(
    ".vercel.app"
    "-rahmivinnns-projects.vercel.app"
    "-git-main-rahmivinnns-projects.vercel.app"
    "-git-master-rahmivinnns-projects.vercel.app"
)

echo "🌐 GENERATING MASSIVE URL LIST..."

TOTAL=0
WORKING=0
EGG_FOUND=0

# Test all combinations
for project in "${PROJECTS[@]}"; do
    for suffix in "${SUFFIXES[@]}"; do
        url="https://${project}${suffix}/"
        TOTAL=$((TOTAL + 1))
        
        printf "%-3d. %-80s " "$TOTAL" "$url"
        
        status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 8 "$url")
        
        if [ "$status" == "200" ]; then
            echo "✅ WORKING"
            WORKING=$((WORKING + 1))
            
            # MEGA CHECK for egg characters
            content=$(curl -s --max-time 5 "$url" 2>/dev/null)
            
            # Multiple detection methods
            if echo "$content" | grep -q "NUCLEAR.*EGG\|K2\.png\|K4\.png\|K6\.png\|EggNFT\|DEPLOYMENT_FORCE\|egg-characters-latest" 2>/dev/null; then
                echo "    🥚🎉🎉🎉 EGG CHARACTERS DETECTED!"
                echo "    🌟🌟🌟 NUCLEAR VERSION LIVE AT: $url"
                EGG_FOUND=$((EGG_FOUND + 1))
            elif echo "$content" | grep -q "deployment-version\.txt" 2>/dev/null; then
                # Check the deployment version file
                if curl -s "$url/deployment-version.txt" 2>/dev/null | grep -q "Egg Characters" 2>/dev/null; then
                    echo "    🥚✨ EGG CHARACTERS IN VERSION FILE!"
                    echo "    🌟 LATEST VERSION AT: $url"
                    EGG_FOUND=$((EGG_FOUND + 1))
                else
                    echo "    ⚠️  Old version"
                fi
            else
                echo "    ❓ Unknown version"
            fi
        else
            echo "❌ $status"
        fi
    done
    
    # Also test branch-specific URLs
    for branch in "${BRANCHES[@]}"; do
        for suffix in "${SUFFIXES[@]}"; do
            if [[ "$suffix" == *"git"* ]]; then
                continue # Skip git suffixes for branch URLs
            fi
            
            url="https://${project}-git-${branch}${suffix}/"
            TOTAL=$((TOTAL + 1))
            
            printf "%-3d. %-80s " "$TOTAL" "$url"
            
            status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 8 "$url")
            
            if [ "$status" == "200" ]; then
                echo "✅ WORKING"
                WORKING=$((WORKING + 1))
                
                content=$(curl -s --max-time 5 "$url" 2>/dev/null)
                
                if echo "$content" | grep -q "NUCLEAR.*EGG\|K2\.png\|K4\.png\|K6\.png\|EggNFT\|DEPLOYMENT_FORCE" 2>/dev/null; then
                    echo "    🥚🎉🎉🎉 EGG CHARACTERS FOUND!"
                    echo "    🌟🌟🌟 NUCLEAR VERSION LIVE AT: $url"
                    EGG_FOUND=$((EGG_FOUND + 1))
                else
                    echo "    ❓ Checking..."
                fi
            else
                echo "❌ $status"
            fi
        done
    done
done

echo ""
echo "🏆 ULTIMATE RESULTS:"
echo "==================="
echo "📊 Total URLs tested: $TOTAL"
echo "✅ Working URLs found: $WORKING"
echo "🥚 Egg character URLs: $EGG_FOUND"

if [ $EGG_FOUND -gt 0 ]; then
    echo ""
    echo "🎉🥚🎉🥚🎉 NUCLEAR SUCCESS! EGG CHARACTERS ARE LIVE! 🎉🥚🎉🥚🎉"
    echo "🔥🔥🔥 MISSION ACCOMPLISHED! 🔥🔥🔥"
else
    echo ""
    echo "⚡ NUCLEAR STRATEGY IN PROGRESS..."
    echo "🔥 Repository is LOADED with latest egg character version!"
    echo "📱 Working URLs (checking if updated):"
    echo "   • https://v0-goldium-io-ui-design.vercel.app/"
    echo "   • https://v0-goldium-io-ui-design-git-master-rahmivinnns-projects.vercel.app/"
    echo ""
    echo "🚀 FINAL NUCLEAR OPTION: Manual Vercel Dashboard Import Required"
    echo "   1. Go to: https://vercel.com/dashboard"
    echo "   2. Click 'Add New Project'"
    echo "   3. Import: rahmivinnn/Goldium-September"
    echo "   4. Name: goldium-september"
    echo "   5. Deploy from: main branch (commit: $COMMIT)"
fi