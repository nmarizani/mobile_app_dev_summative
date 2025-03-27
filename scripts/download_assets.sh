#!/bin/bash

# Create directories if they don't exist
mkdir -p assets/images
mkdir -p assets/icons

# Function to download placeholder image
download_placeholder() {
    local path=$1
    local width=$2
    local height=$3
    local text=$4
    local bgcolor=${5:-cccccc}
    local textcolor=${6:-666666}
    
    curl -s "https://via.placeholder.com/${width}x${height}/${bgcolor}/${textcolor}?text=${text}" > "$path"
    echo "Downloaded: $path"
}

# Download category icons (48x48)
download_placeholder "assets/icons/watch.png" 48 48 "Watch"
download_placeholder "assets/icons/headphone.png" 48 48 "Headphone"
download_placeholder "assets/icons/speaker.png" 48 48 "Speaker"
download_placeholder "assets/icons/smart_watch.png" 48 48 "Smart"
download_placeholder "assets/icons/sport_watch.png" 48 48 "Sport"
download_placeholder "assets/icons/luxury_watch.png" 48 48 "Luxury"

# Download product images (800x800)
download_placeholder "assets/images/watch1.png" 800 800 "Watch%201"
download_placeholder "assets/images/watch2.png" 800 800 "Watch%202"
download_placeholder "assets/images/headphone1.png" 800 800 "Headphone%201"
download_placeholder "assets/images/headphone2.png" 800 800 "Headphone%202"
download_placeholder "assets/images/speaker1.png" 800 800 "Speaker%201"
download_placeholder "assets/images/speaker2.png" 800 800 "Speaker%202"

# Download UI elements
download_placeholder "assets/images/profile_image.png" 200 200 "Profile"
download_placeholder "assets/images/banner.png" 1080 400 "Special%20Offer" "FF4081" "FFFFFF"
download_placeholder "assets/images/empty_orders.png" 400 400 "No%20Orders"

# Download navigation icons (24x24)
download_placeholder "assets/icons/home.png" 24 24 "Home"
download_placeholder "assets/icons/categories.png" 24 24 "Cat"
download_placeholder "assets/icons/cart.png" 24 24 "Cart"
download_placeholder "assets/icons/profile.png" 24 24 "Profile"
download_placeholder "assets/icons/back.png" 24 24 "Back"
download_placeholder "assets/icons/search.png" 24 24 "Search"

# Download profile icons (24x24)
download_placeholder "assets/icons/shipping.png" 24 24 "Ship"
download_placeholder "assets/icons/payment.png" 24 24 "Pay"
download_placeholder "assets/icons/history.png" 24 24 "History"
download_placeholder "assets/icons/privacy.png" 24 24 "Privacy"
download_placeholder "assets/icons/terms.png" 24 24 "Terms"
download_placeholder "assets/icons/faq.png" 24 24 "FAQ"
download_placeholder "assets/icons/password.png" 24 24 "Pass"
download_placeholder "assets/icons/theme.png" 24 24 "Theme"
download_placeholder "assets/icons/edit.png" 24 24 "Edit"

echo "All assets downloaded successfully!" 