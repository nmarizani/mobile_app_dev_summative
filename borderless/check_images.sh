#!/bin/bash

# Arrays of required files
declare -a images=(
    "logo.png"
    "profile.png"
    "banner.png"
    "nike_shoes.png"
    "glasses.png"
    "laptop.png"
    "mobile.png"
    "headphones.png"
    "smartwatch.png"
    "mobile_case.png"
    "monitor.png"
)

declare -a icons=(
    "electronics.png"
    "fashion.png"
    "furniture.png"
    "industrial.png"
    "home_decor.png"
    "electronics_alt.png"
    "health.png"
    "construction.png"
    "fabrication.png"
    "electrical.png"
    "google.png"
)

echo "Checking images..."
for img in "${images[@]}"; do
    if [ -s "assets/images/$img" ]; then
        echo "✅ assets/images/$img exists and has content"
    elif [ -f "assets/images/$img" ]; then
        echo "⚠️  assets/images/$img exists but is empty"
    else
        echo "❌ assets/images/$img is missing"
    fi
done

echo -e "\nChecking icons..."
for icon in "${icons[@]}"; do
    if [ -s "assets/icons/$icon" ]; then
        echo "✅ assets/icons/$icon exists and has content"
    elif [ -f "assets/icons/$icon" ]; then
        echo "⚠️  assets/icons/$icon exists but is empty"
    else
        echo "❌ assets/icons/$icon is missing"
    fi
done 