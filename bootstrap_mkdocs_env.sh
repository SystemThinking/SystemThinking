#!/bin/bash

# Create virtual environment
python3 -m venv .venv

# Activate virtual environment
source .venv/bin/activate

# Upgrade pip and install dependencies
pip install --upgrade pip
pip install mkdocs mkdocs-material mkdocs-static-i18n mkdocs-awesome-pages-plugin

echo "✅ Virtual environment created and MkDocs stack installed."
echo "➡️ To activate later, run: source .venv/bin/activate"
