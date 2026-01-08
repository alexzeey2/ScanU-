#!/bin/bash

echo "🚀 Balance Scanner - Quick Deployment Script"
echo "============================================="
echo ""
echo "This script will help you deploy to Vercel in 2 minutes!"
echo ""

# Check if we're in the right directory
if [ ! -f "index.html" ] || [ ! -f "manifest.json" ]; then
    echo "❌ Error: Please run this script from the balance-scanner directory"
    exit 1
fi

echo "📦 Current directory: $(pwd)"
echo "✅ All required files found!"
echo ""

# Ask for GitHub username
echo "📝 STEP 1: GitHub Setup"
echo "----------------------"
read -p "Enter your GitHub username: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "❌ Username cannot be empty"
    exit 1
fi

REPO_NAME="balance-scanner"
REPO_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

echo ""
echo "✅ Configuration:"
echo "   GitHub User: $GITHUB_USERNAME"
echo "   Repository: $REPO_NAME"
echo "   URL: $REPO_URL"
echo ""

# Check if git repo is initialized
if [ ! -d ".git" ]; then
    echo "🔧 Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: Balance Scanner PWA"
fi

# Check if remote already exists
if git remote | grep -q "origin"; then
    echo "🔧 Removing old remote..."
    git remote remove origin
fi

# Add new remote
echo "🔗 Adding GitHub remote..."
git remote add origin "$REPO_URL"
git branch -M main

echo ""
echo "✅ Git repository configured!"
echo ""
echo "📤 STEP 2: Create GitHub Repository"
echo "------------------------------------"
echo ""
echo "Please complete these steps:"
echo ""
echo "1. Open this URL in your browser:"
echo "   👉 https://github.com/new"
echo ""
echo "2. Set repository name to: $REPO_NAME"
echo "3. Make it PUBLIC (very important!)"
echo "4. DO NOT check 'Add a README file'"
echo "5. Click 'Create repository'"
echo ""
read -p "Press ENTER when you've created the repository..."

# Try to push
echo ""
echo "📤 STEP 3: Pushing code to GitHub..."
echo "------------------------------------"
echo ""

if git push -u origin main; then
    echo ""
    echo "✅ Code successfully pushed to GitHub!"
    echo ""
    echo "🚀 STEP 4: Deploy to Vercel"
    echo "----------------------------"
    echo ""
    echo "Now deploy to Vercel:"
    echo ""
    echo "1. Open this URL:"
    echo "   👉 https://vercel.com/new"
    echo ""
    echo "2. Click 'Import Git Repository'"
    echo "3. Find and select: $REPO_NAME"
    echo "4. Click 'Import'"
    echo "5. Click 'Deploy' (don't change settings)"
    echo "6. Wait 30 seconds..."
    echo ""
    echo "✅ Your app will be live at:"
    echo "   https://$REPO_NAME-$GITHUB_USERNAME.vercel.app"
    echo ""
    echo "🎉 Congratulations! Your Balance Scanner is now live!"
    echo ""
else
    echo ""
    echo "❌ Push failed. This usually means:"
    echo ""
    echo "1. You haven't created the GitHub repository yet"
    echo "   Solution: Go to https://github.com/new and create it"
    echo ""
    echo "2. The repository name is wrong"
    echo "   Solution: Make sure it's exactly '$REPO_NAME'"
    echo ""
    echo "3. You don't have permission"
    echo "   Solution: Make sure you're logged into GitHub"
    echo ""
    echo "After fixing, run this command manually:"
    echo "   git push -u origin main"
    echo ""
    echo "Then continue with Vercel deployment at:"
    echo "   https://vercel.com/new"
    echo ""
fi

echo ""
echo "📚 Need help? Check these files:"
echo "   - DEPLOY_NOW_GUIDE.md (step-by-step instructions)"
echo "   - QUICK_START.md (quick reference)"
echo "   - VERCEL_DEPLOYMENT_GUIDE.md (detailed guide)"
echo ""
