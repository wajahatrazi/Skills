# How To Use Skills & Auto-Sync Guide

## 1. How It Works (The Zero-Fuss Architecture)

You only ever interact with one folder: `~/.skills/`.

Whenever you add, modify, or delete a skill inside `~/.skills/`:
1. **Antigravity (Gemini)** gets it automatically via `~/.gemini/config/skills/`.
2. **Claude Code** gets it automatically via `~/.claude/skills/`.
3. **GitHub (`git@github.com:wajahatrazi/Skills.git`)** gets it automatically backed up and pushed.

---

## 2. Automatic Background Sync (systemd Service)

A lightweight `systemd --user` background service runs automatically every **5 minutes** without requiring root/sudo permissions:

* **Timer status**:
  ```bash
  systemctl --user status skills-sync.timer
  ```
* **View recent sync logs**:
  ```bash
  journalctl --user -u skills-sync.service -n 20 --no-pager
  ```

You do not have to run any commands. You just edit or add files in `~/.skills/`, and the background service commits and pushes to GitHub for you.

---

## 3. Manual Sync (Whenever You Want Instant Sync)

If you don't want to wait 5 minutes and want to force an immediate push or pull:

Just type this command anywhere in your terminal:
```bash
sync-skills
```
Or with a custom commit message:
```bash
sync-skills "Added my custom coding skill"
```

---

## 4. How Other AI Tools (e.g., OpenAI) Use These Skills

All skills follow the standard `SKILL.md` format (YAML frontmatter + Markdown instructions).

### A. OpenAI Custom GPTs & Assistants API
* Simply upload the `SKILL.md` file from `~/.skills/<skill_name>/SKILL.md` as a Knowledge document, or copy-paste its instructions into the Assistant's **Instructions / System Prompt**.

### B. Cursor / Windsurf / VS Code Copilot
* In your project's `.cursorrules` or `.windsurfrules`, add a reference:
  `Include instructions from ~/.skills/<skill_name>/SKILL.md`

### C. Python / LangChain / CrewAI / Agents
* Load the skill directly from disk in Python:
  ```python
  with open("/home/tk-lpt-994/.skills/humanizer/SKILL.md") as f:
      system_instructions = f.read()
  ```

### D. If OpenAI releases a CLI with a local skills folder
* We can simply add a one-line symlink into `sync.sh`:
  `ln -s ~/.skills ~/.openai/skills`
