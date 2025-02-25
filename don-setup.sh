#!/bin/bash

# Check if node_modules directory exists in the don folder
if [ ! -d "don/node_modules" ]; then
    echo "node_modules not found in don directory. Installing dependencies..."
    cd don && npm install
    cd ..
    echo "Dependencies installed successfully."
else
    echo "node_modules already exists in don directory. Skipping installation."
fi

