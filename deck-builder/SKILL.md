---
name: deck-builder
description: >-
  Build presentation decks end to end — outline first, then generate slides. Use whenever the user mentions a deck, slides, presentation, talk, workshop, keynote, pitch deck, or asks to 'make me a deck' or 'build slides for'.
---

# Deck Builder

## Overview
This skill turns a topic or raw material into a finished, compelling presentation. It operates in three rigorous steps:
1. Gather a tight brief.
2. Build a slide-by-slide outline and get explicit user approval.
3. Generate the deck (via Gamma if connected, or as standalone modern HTML/reveal.js slides / Marp presentation).

Nothing is generated until the outline is approved. The skill controls narrative flow and concise writing; the user controls overall direction and approval.

---

## Step 1 — Gather the brief
Before writing anything, collect these key inputs. Ask for whatever is missing — never guess:

**Required:**
- **Topic**: The core message or thesis.
- **Audience**: Who is in the room (e.g. executive stakeholders, engineering team, non-technical clients, investors).
- **Length**: Target slide count or talk duration (default: 8–12 slides if unspecified).
- **Key Takeaways**: What the audience should understand, decide, or do afterward.

**Optional (Ask if relevant):**
- Tone and style (e.g. bold and persuasive, analytical, inspirational, educational).
- Source materials to draw from (docs, markdown notes, articles, research).
- Format preference (Gamma presentation, standalone modern HTML slides, or Marp Markdown).

---

## Step 2 — Build the outline
The outline is the foundation of the deck:
- Present every slide clearly as `Slide [number]: [Title]` with a 1–2 sentence description of content and visual idea underneath.
- **One Slide, One Job**: Every slide communicates exactly one concept, metric, or decision point.
- **Active, Hooking Titles**: Write titles that state the takeaway or provoke curiosity (e.g., *"Deployment Frequency Increased 5x"* instead of *"Deployment Metrics"*).
- **First Slide**: Hooks immediately with a bold claim, a high-stakes challenge, or a compelling question.
- **Middle Slides**: Build evidence, context, methodology, and actionable insights with logical progression.
- **Final Slide**: Synthesizes the core conclusion and provides one concrete next step, call to action, or Q&A trigger.

**WAIT FOR APPROVAL**: Present the outline to the user and pause. Do not generate the full slides until the user approves or requests revisions.

---

## Step 3 — Generate the Presentation

### Path A: If Gamma MCP (`Gamma:generate`) is Available
Send the approved outline to Gamma with these recommended parameters:
```
format: "presentation"
textMode: "generate"
numCards: <approved slide count>
textOptions.audience: <from the brief>
textOptions.amount: "medium"
textOptions.tone: "professional and engaging"
imageOptions.source: "aiGenerated"
imageOptions.stylePreset: "photorealistic"
```
Share the generated Gamma link with the user.

### Path B: Standalone Web / Marp Presentation (Native Fallback)
If Gamma is not configured, generate a standalone presentation:
- **Interactive HTML/CSS Deck**: Single-file HTML using modern typography (e.g., Inter/Outfit), sleek dark mode or clean minimalist styling, keyboard navigation (`ArrowLeft` / `ArrowRight`), slide indicators, and mobile-friendly responsiveness.
- **Marp Markdown**: Clean Markdown slides formatted with `---` separators, directives (`theme: gaia`, `_class: lead`), and clear visual hierarchy.

---

## Writing Rules for Slides

**Enforce:**
- Write like a sharp human communicating with peers, not a marketer reading a script.
- Address the audience directly with "you" or direct statements.
- Short sentences and punchy fragments suitable for quick reading.
- Specificity: concrete numbers, named examples, clear step-by-step guidance.
- Active voice only.

**Banned Corporate Buzzwords (rewrite if any appear):**
delve, realm, harness, unlock, tapestry, leverage, seamless, robust, game-changer, elevate, unprecedented, synergy, pivotal.

**Banned Cliché Phrases:**
- "In today's fast-paced world..."
- "It's important to note..."
- "Let's dive into..."
- "At the end of the day..."

**Banned AI Structural Patterns:**
- Negative parallelisms (*"It's not about X; it's about Y"*).
- Compulsive lists of three (the "rule of three" syndrome).
- Identical grammatical structures across every slide title.
- Significance inflation and empty superlatives.

---

## Quality Checklist
Before handing off the outline or generating slides, verify:
- [ ] Every slide has one unmistakable purpose.
- [ ] Titles are active claims, not passive category names.
- [ ] First slide creates immediate engagement; final slide provides actionable closure.
- [ ] Slide-to-slide narrative flow is smooth and logical.
- [ ] Zero banned buzzwords or robotic AI patterns.
- [ ] Slide count precisely matches the agreed brief.

---

## Scope Guardrails
This skill is exclusively for presentations, talks, webinars, and pitch outlines. It does NOT generate:
- Long-form prose, newsletters, or blog posts (use dedicated writing skills instead).
- Unstructured slide dumps without an approved outline.
