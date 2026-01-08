#!/bin/bash

# Balance Scanner - Quick GitHub & Vercel Setup Script
# This script helps you push your app to GitHub and deploy to Vercel

echo "🚀 Balance Scanner - Deployment Helper"
echo "======================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install git first."
    exit 1
fi

# Get user info
echo "📝 Let's set up your GitHub repository"
echo ""
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter repository name (default: balance-scanner): " REPO_NAME
REPO_NAME=${REPO_NAME:-balance-scanner}

echo ""
echo "✅ Configuration:"
echo "   GitHub User: $GITHUB_USERNAME"
echo "   Repository: $REPO_NAME"
echo ""

# Initialize git if not already done
if [ ! -d .git ]; then
    echo "📦 Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: Balance Scanner PWA with AI detection"
fi

# Set remote
echo "🔗 Setting up GitHub remote..."
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# Rename branch to main
git branch -M main

echo ""
echo "✅ Git repository configured!"
echo ""
echo "📤 Next steps:"
echo "1. Create the repository on GitHub:"
echo "   👉 Visit: https://github.com/new"
echo "   👉 Name: $REPO_NAME"
echo "   👉 Make it Public"
echo "   👉 Do NOT initialize with README"
echo ""
echo "2. After creating the repo, run:"
echo "   git push -u origin main"
echo ""
echo "3. Deploy to Vercel:"
echo "   👉 Visit: https://vercel.com/new"
echo "   👉 Import your GitHub repository"
echo "   👉 Click Deploy!"
echo ""
echo "🎉 Your app will be live in under 60 seconds!"
echo ""

read -p "Press Enter to exit..."
