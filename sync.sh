#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEMINI_DIR="$HOME/.gemini/config/skills"

case "$1" in
  save|push)
    echo "Syncing active skills from ~/.gemini/config/skills -> $REPO_DIR ..."
    rsync -av --delete --exclude='.git' --exclude='.gitignore' --exclude='sync.sh' --exclude='__pycache__' "$GEMINI_DIR/" "$REPO_DIR/"
    cd "$REPO_DIR"
    git add -A
    msg="${2:-Update skills}"
    if git diff --cached --quiet; then
      echo "No changes to commit."
    else
      git commit -m "$msg"
      git push origin main
      echo "✓ Pushed to GitHub successfully!"
    fi
    ;;
  apply|pull)
    echo "Pulling latest skills from GitHub ..."
    cd "$REPO_DIR"
    git pull origin main
    echo "Applying to active agent directory ~/.gemini/config/skills ..."
    mkdir -p "$GEMINI_DIR"
    rsync -av --delete --exclude='.git' --exclude='.gitignore' --exclude='sync.sh' --exclude='__pycache__' "$REPO_DIR/" "$GEMINI_DIR/"
    echo "✓ Active skills updated successfully!"
    ;;
  *)
    echo "Usage: ./sync.sh [save \"commit message\" | apply]"
    echo "  ./sync.sh save \"message\"  -> Syncs from active agent, commits, and pushes to GitHub"
    echo "  ./sync.sh apply            -> Pulls from GitHub and updates active agent skills"
    ;;
esac
