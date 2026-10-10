#!/usr/bin/env bash
# ==============================================================================
# Universal Skills Sync: Keeps ~/.skills, Antigravity, Claude & GitHub in sync.
# ==============================================================================
set -e

REPO_DIR="/home/tk-lpt-994/Music/Skills"
GEMINI_DIR="$HOME/.gemini/config/skills"
DOT_SKILLS="$HOME/.skills"
CLAUDE_DIR="$HOME/.claude/skills"

# 1. Ensure master runtime directories exist
mkdir -p "$GEMINI_DIR"
mkdir -p "$CLAUDE_DIR"

# Ensure ~/.skills points to or exists as master
if [ ! -e "$DOT_SKILLS" ]; then
  ln -s "$GEMINI_DIR" "$DOT_SKILLS"
fi

# Determine source directory (if ~/.skills is a symlink, resolve to physical)
if [ -L "$DOT_SKILLS" ]; then
  SRC_DIR="$GEMINI_DIR"
else
  SRC_DIR="$DOT_SKILLS"
  # If ~/.skills is physical, sync it into ~/.gemini/config/skills
  rsync -a --delete --exclude='.git' --exclude='.gitignore' --exclude='sync.sh' --exclude='__pycache__' "$SRC_DIR/" "$GEMINI_DIR/"
fi

# 2. Sync into Git repository directory
rsync -a --delete \
  --exclude='.git' \
  --exclude='.gitignore' \
  --exclude='sync.sh' \
  --exclude='HowToUse_sync.md' \
  --exclude='__pycache__' \
  "$SRC_DIR/" "$REPO_DIR/"

# 3. Ensure Claude has symlinks for all skills
for skill_path in "$SRC_DIR"/*; do
  if [ -d "$skill_path" ]; then
    skill_name=$(basename "$skill_path")
    # Link from ~/.skills/$skill_name to ~/.claude/skills/$skill_name
    ln -sfn "$DOT_SKILLS/$skill_name" "$CLAUDE_DIR/$skill_name"
  fi
done

# 4. Git Tracking & Push in ~/Music/Skills
cd "$REPO_DIR"

# Optional: Pull remote changes if available
git fetch origin main --quiet 2>/dev/null || true
LOCAL_REV=$(git rev-parse HEAD 2>/dev/null || echo "")
REMOTE_REV=$(git rev-parse origin/main 2>/dev/null || echo "")

if [ -n "$REMOTE_REV" ] && [ "$LOCAL_REV" != "$REMOTE_REV" ]; then
  # Merge remote changes
  git pull --rebase origin main --quiet 2>/dev/null || true
  # Update local active runtime with remote changes
  rsync -a --delete \
    --exclude='.git' \
    --exclude='.gitignore' \
    --exclude='sync.sh' \
    --exclude='HowToUse_sync.md' \
    --exclude='__pycache__' \
    "$REPO_DIR/" "$SRC_DIR/"
fi

# Check for local changes to commit & push
git add -A
if ! git diff --cached --quiet; then
  COMMIT_MSG="${1:-Auto-sync skills: $(date '+%Y-%m-%d %H:%M:%S')}"
  if [ "$1" = "auto" ]; then
    COMMIT_MSG="Auto-sync skills: $(date '+%Y-%m-%d %H:%M:%S')"
  fi
  git commit -m "$COMMIT_MSG" --quiet
  git push origin main --quiet
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] Synced and pushed changes to GitHub."
else
  if [ "$1" != "auto" ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] All skills are already in sync with GitHub."
  fi
fi
