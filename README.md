# Novel Studio for Claude Code — Multi-Agent Novel Creation System

> **Is Claude Code just a coding tool?** Think again.
> **Claude Code is the ultimate novel-writing studio.**
> Clone this repo, open Claude Code, and say *"Write me a novel"* — that's it.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Built%20with-Claude%20Code-blue)](https://docs.anthropic.com/en/docs/claude-code)
[![Agents](https://img.shields.io/badge/Agents-14%20Specialized-green)](.github/agents/)

**[한국어 README](README_KO.md)**

---

## Overview

Novel Studio is a system where **14 specialized AI agents** collaborate to create publication-quality novels — orchestrated natively on **Claude Code**.

Say `"Write me a novel"` and the agent team handles everything: planning, writing, editing, and quality control.

### Why Claude Code?

Claude Code goes beyond coding — it provides a full agent orchestration platform:

- **CLAUDE.md auto-loading** — system activates the moment you open the project
- **`.github/agents/` convention** — 14 specialists invocable by reading agent files
- **Task tool** — sub-agent spawning for parallel quality control
- **Agent Mode** — autonomous multi-step execution
- **File-based workflow** — manuscripts live in files, not chat context

### Key Features

- **14 Specialized Agents**: 7 planning + 4 writing + 3 quality control
- **Hybrid Architecture**: Prompt Library pattern (creative) + Sub-Agent Spawn (quality)
- **Context-Optimized**: CLAUDE.md kept minimal; orchestration logic loaded on-demand
- **Scene Specialization**: Dedicated writers for dialogue / action / emotion scenes
- **Bilingual**: Full English and Korean agent support
- **Human-in-the-Loop**: User approval at key checkpoints only (5-7 times)
- **Proven Quality**: 91/100 publication-grade output (validated on real project)

---

## Quick Start

### 1. Clone & Enter

```bash
git clone https://github.com/route99-roadRunner/novel-studio-claude.git
cd novel-studio-claude
```

### 2. Run Claude Code

```bash
claude
```

### 3. Start Writing

```
"Write me a novel"
```

or in Korean:

```
"소설 써줘"
```

The Main Writer agent will confirm your language preference, then guide you through the entire process.

---

## How It Works

### Hybrid Architecture

```
Phase 1: Planning [Prompt Library Pattern]
  → Main Writer reads agent files and performs each role sequentially
  → Story / Character / Setting / Genre / Opening Hook / Pacing

Phase 2: Writing [Prompt Library] + Quality Review [Sub-Agent Spawn]
  → Scene-type specialists: Dialogue / Action / Emotion / Prose
  → Per-chapter: Editorial Team + Feedback Agent spawned in parallel

Phase 3: Finalization [Sub-Agent Spawn]
  → Editorial + Feedback + Research agents spawned in parallel
  → Main Writer integrates reports into final manuscript
```

### Agent Orchestration

```
User → CLAUDE.md (system config, auto-loaded)
         ↓
       Main Writer (coordinator) reads .agent.md files
         ↓
       Story + Character + Setting + Genre + Opening Hook + Pacing
         ↓
       Dialogue / Action / Emotion / Prose writers
         ↓
       Editorial Team + Feedback Agent + Research Agent (sub-agent spawn)
```

### Approval Checkpoints

| Checkpoint | When |
|------------|------|
| Phase 1 Complete | Planning docs ready for review |
| Each Chapter | Chapter draft completed |
| Phase 3 Complete | Final manuscript ready |

---

## Agent Team (14 Agents)

| Phase | Agent | Role |
|-------|-------|------|
| **Planning** | Main Writer | Project coordinator & quality gate |
| | Story Writer | Plot construction, narrative arcs |
| | Character Writer | Character creation, relationships |
| | Setting Writer | World-building, environments |
| | Genre Specialist | Genre analysis, trope strategy |
| | Opening Hook Specialist | Chapter 1 hook strategy, reader retention |
| | Pacing Manager | Tempo control, rhythm management |
| **Writing** | Dialogue Writer | Conversation scene specialist |
| | Action Writer | Action/combat scene specialist |
| | Emotion Writer | Emotion/introspection specialist |
| | Prose Writer | General narrative prose |
| **Quality** | Editorial Team | Proofreading, editing, consistency |
| | Feedback Agent | Reader perspective evaluation (5 personas) |
| | Research Agent | Fact-checking, verification |

All agents have both English and Korean (`ko-`) variants.

---

## Project Structure

```
novel-studio-claude/
├── CLAUDE.md                          ← System config (auto-loaded, ~24 lines)
├── .github/agents/                    ← 14 specialized agents (+ 14 Korean variants)
│   ├── main-writer.agent.md
│   ├── story-writer.agent.md
│   ├── character-writer.agent.md
│   ├── setting-writer.agent.md
│   ├── genre-specialist.agent.md
│   ├── opening-hook.agent.md
│   ├── pacing-manager.agent.md
│   ├── dialogue-writer.agent.md
│   ├── action-writer.agent.md
│   ├── emotion-writer.agent.md
│   ├── prose-writer.agent.md
│   ├── editorial-team.agent.md
│   ├── feedback-agent.agent.md
│   ├── research-agent.agent.md
│   ├── ko-*.agent.md                 ← Korean language variants
│   ├── orchestration.md              ← Agent registry & Phase flow (loaded on-demand)
│   └── examples/                     ← Output format examples (loaded on-demand)
├── hooks/                             ← Claude Code lifecycle hooks
├── scripts/                           ← Quality assurance utilities
└── projects/                          ← Generated novel output
    ├── ko/first_love_001/             ← Korean demo project
    └── love_story_heroes/             ← English demo project
```

### Generated Novel Structure

```
projects/{language}/{project_name}/
├── phase1_planning/       ← Plot, characters, setting, genre docs
├── phase2_chapters/       ← Chapter drafts & finals
├── phase3_final/          ← Integrated novel + editorial/feedback reports
├── notes/
│   ├── session-log.md     ← Session work log (compaction recovery)
│   └── revision-notes.md  ← Revision history
└── .novel-studio/
    ├── status.json        ← Progress status
    ├── checkpoints/       ← Checkpoints
    └── backups/           ← Automatic backups
```

---

## Context Optimization (v2.2)

Based on research showing that excessive context files degrade agent performance, v2.2 applies a **minimal-context-per-agent** principle:

| Component | Strategy |
|-----------|----------|
| `CLAUDE.md` (auto-loaded every conversation) | Slimmed to ~24 lines — essential rules only |
| `orchestration.md` | Agent registry + Phase flow — loaded only when Main Writer needs it |
| `examples/` (3 files) | Output format examples — loaded only when writing |
| Agent `.md` files | Each agent is self-contained with inline instructions |

---

## Demo Projects

### `first_love_001` — Korean College Romance
- **Location**: `projects/ko/first_love_001/`
- **Quality**: 91/100 (publication-grade)
- **Length**: 11,900 chars / 3 chapters

### `love_story_heroes` — English Fantasy Adventure
- **Location**: `projects/love_story_heroes/`
- **Demonstrates**: Bilingual agent system, multi-genre planning

---

## Usage Examples

**Basic:**
```
"Write me a college campus romance novel"
```

**Detailed:**
```
Project: campus_love
Idea: First love between an engineering student and humanities student. Cherry blossom season.
Length: 3 chapters
```

**Continue:**
```
"Continue the first_love project"
```

**Rewrite:**
```
"Rewrite Chapter 2. Incorporate feedback from editorial report."
```

---

## Work Modes

| Mode | Interventions | Best For |
|------|---------------|----------|
| **Review** (Recommended) | 5-7 times | Most users |
| **Auto** | 3 times | Quick prototypes |
| **Manual** | 15-20 times | Full creative control |

---

## Version History

| Version | Changes |
|---------|---------|
| **v2.2** (Current) | Opening Hook Specialist added (14 agents), context optimization (-74% CLAUDE.md), orchestration.md + examples/ extraction, hybrid architecture |
| v2.0 | Migration to Claude Code, 13 agents, hooks system, bilingual support |
| v1.0 (Beta) | 8 agents, manual mode only |

---

## Contributing

Contributions welcome:
1. Add or improve agent profiles in `.github/agents/`
2. Add quality scripts to `scripts/`
3. Improve documentation
4. Share novel projects as demos

---

## License

[MIT License](LICENSE)

---

**Novel Studio for Claude Code — by [route99-roadRunner](https://github.com/route99-roadRunner)**

Version: 2.2 | Status: Production Ready

*"Your Story, Our Craft."*
