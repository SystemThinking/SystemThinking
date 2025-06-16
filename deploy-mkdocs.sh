#!/bin/bash
echo "🔄 Building site..."
mkdocs build --clean

echo "🚀 Deploying to GitHub Pages..."
mkdocs gh-deploy --clean

echo "✅ Done! Check:"
echo "https://06-sth-projects.github.io/repo_sthdf-2023-2024/"
