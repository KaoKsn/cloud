#!/usr/bin/bash
# Usage: ./launch.sh [stop]

if [ -z "$1" ]; then
    choice="launch"
else
    choice=$1
fi
dirs=("proxy" "searxng" "tea" "profile" "beszel")

if [ "$choice" == "stop" ]; then
    echo "Stopping services..."
    cd services
    for service in ${dirs[@]}; do
        echo "Launching $service..."
        cd "$service" && docker compose down
        cd ../
    done
else
    echo "Launching services..."
    cd services
    for service in ${dirs[@]}; do
        echo "Launching $service..."
        cd "$service" && docker compose down 2>/dev/null && docker compose up -d
        cd ../
    done
fi

echo "Complete."
