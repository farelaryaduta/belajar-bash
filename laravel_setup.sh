#!/bin/bash

# Simple Laravel Project Builder Script

# Base directory
BASE_DIR="/mnt/d"

echo "=============================="
echo "  Laravel Project Builder"
echo "=============================="
echo ""

# Ask for project name
read -r -p "Enter project name: " PROJECT_NAME

# Validate project name
if [[ -z "$PROJECT_NAME" ]]; then
    echo "Error: Project name cannot be empty!"
    exit 1
fi

# Check if directory already exists
if [[ -d "$BASE_DIR/$PROJECT_NAME" ]]; then
    echo "Error: Directory $BASE_DIR/$PROJECT_NAME already exists!"
    exit 1
fi

# Create the project
echo ""
echo "Creating Laravel project '$PROJECT_NAME' in $BASE_DIR..."
echo ""

cd "$BASE_DIR" || exit 1
composer create-project laravel/laravel "$PROJECT_NAME"

if [[ $? -eq 0 ]]; then
    echo ""
    echo "=============================="
    echo "  Done!"
    echo "=============================="
    echo ""
    echo "Project created at: $BASE_DIR/$PROJECT_NAME"
    echo ""
    echo "To start the server:"
    echo "  cd $BASE_DIR/$PROJECT_NAME"
    echo "  php artisan serve"
else
    echo ""
    echo "Error: Failed to create project!"
    exit 1
fi
