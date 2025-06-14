#!/bin/bash
REPO_NAME=$1
ORG_NAME=$2

if [ -z "$REPO_NAME" ] || [ -z "$ORG_NAME" ]; then
  echo "❌ Použitie: ./init-repo.sh <repo> <org>"
  exit 1
fi

#cd "$REPO_NAME" || { echo "❌ Repozitár '$REPO_NAME' neexistuje"; exit 1; }

# Inicializuj git
git init

# Vytvor .gitignore, ak neexistuje
if [ ! -f .gitignore ]; then
  echo "🔧 Vytváram predvolený .gitignore..."
  cat <<EOF > .gitignore
# Python
__pycache__/
*.py[cod]
*.egg-info/
.env/
.venv/

# MkDocs / Docs
/site/
*.log

# OS
.DS_Store
Thumbs.db

# GitHub Actions logs
.github/*.log
EOF
else
  echo "📄 .gitignore už existuje, neprepísal som ho."
fi

git add .
git commit -m "Initial commit from template"
git branch -M main
git remote add origin "https://github.com/$ORG_NAME/$REPO_NAME.git"
git push -u origin main
