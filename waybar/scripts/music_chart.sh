#!/bin/bash

# Check if MPV is playing
if playerctl -p mpv status | grep -q "Playing"; then
    # Get current song
    song=$(playerctl -p mpv metadata --format '{{artist}} - {{title}}')

    # Fetch top trending songs (scraped from Billboard)
    charts=$(curl -s "https://www.billboard.com/charts/hot-100/" | grep -oP '(?<=class="c-title  a-no-trucate a-font-primary-bold-s u-letter-spacing-0021 lrv-u-font-size-18@tablet lrv-u-font-size-16 u-line-height-normal@tablet u-line-height-normal@mobile-max  u-display-block a-truncate-ellipsis-2line u-max-width-330 u-max-width-230@tablet-only u-letter-spacing-0021 a-truncate-ellipsis-2line u-display-block u-max-width-230@tablet-only")>.*?</h3>' | sed -E 's/<[^>]+>//g' | head -n 5 | paste -sd ' | ')

    # Display song + charts
    echo "🎵 $song | Top Songs: $charts"
else
    echo ""
fi

