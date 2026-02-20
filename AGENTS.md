# Novel Studio for Claude Code - Project Overview

Welcome to **Novel Studio for Claude Code**! An AI-powered multi-agent novel creation studio optimized for Claude Code.

## How It Works

Novel Studio uses a **Prompt Library** pattern: Claude reads each `.agent.md` file and performs that specialized role, then returns to the Main Writer role. There are 13 specialized agents covering planning, writing, and quality control.

## Our Team

**Planning Phase (Phase 1)**
- **Main Writer**: Overall project director and quality manager
- **Story Writer**: Plot structure and narrative development
- **Character Writer**: Character creation and development
- **Setting Writer**: Worldbuilding and environment design
- **Genre Specialist**: Genre analysis and trope strategy
- **Pacing Manager**: Tempo control and rhythm management

**Writing Phase (Phase 2)**
- **Dialogue Writer**: Specialized in conversation scenes
- **Action Writer**: Specialized in action/combat scenes
- **Emotion Writer**: Specialized in emotional/internal scenes
- **Prose Writer**: General narrative and description

**Quality Control (Phase 2-3)**
- **Editorial Team**: Proofreading, editing, and quality management
- **Feedback Agent**: Reader perspective and feedback
- **Research Agent**: Fact-checking and research

## Work Process

```
Phase 1: Planning
  - Concept refinement
  - Plot/Character/Setting design

Phase 2: Writing
  - Chapter outlines
  - Manuscript writing (scene-specialized agents)
  - Editing and feedback

Phase 3: Completion
  - Full integration
  - Final editing
  - Quality verification
```

## Work Modes

### Review Mode (Recommended)
- **Interventions**: 5-7 times
- **Checkpoints**: Planning done, each chapter done, final completion
- **Best for**: Those who want moderate control

### Auto Mode
- **Interventions**: 3 times
- **Checkpoints**: Start, planning done, final completion
- **Best for**: Quick prototypes, high system trust

### Manual Mode
- **Interventions**: 15-20 times
- **Checkpoints**: Every work stage
- **Best for**: Those who want detailed control

## Deliverables

- **Length**: Approx. 9,000-12,000 words (3 chapters)
- **Quality**: 75/100+ (per chapter), 85/100+ (publication)
- **Format**: Markdown (.md)
- **Contents**: Planning docs, chapter manuscripts, editorial report, feedback report

---

## How to Request

### Quick Request
```
"Write me a [genre/theme] novel"
```

### Detailed Request
```
Project name: [name]
Idea: [detailed description]
Mode: [auto/review/manual]
Length: [number of chapters, default 3]
```

---

## Language Support

**English** (Default): Agents without prefix
**한국어** (Korean): Agents with `ko-` prefix

The Main Writer will ask your language preference when you start.

---

## Track Record

### Real Project: first_love_001
- **Genre**: College romance
- **Length**: 11,900 words (3 chapters)
- **Quality**: 91/100
- **Status**: Publication Ready

### Strengths
- Scene Specialization: Dedicated writer for dialogue/action/emotion
- Genre Optimization: Genre specialist creates trope strategy
- Tempo Management: Pacing manager controls rhythm
- Web Novel Support: Korean web novel genre optimization (fantasy/isekai/regression)
- Human-in-the-Loop: User confirmation at critical moments

---

## Reference Materials

- **Workflow Guide**: `WORKFLOW_GUIDE.md` (13 agent integration)
- **Agent Profiles**: `.github/agents/*.agent.md` (13 agents x 2 languages)
- **Configuration**: `config.yaml`

---

**Novel Studio for Claude Code**
*"Your story, our creation."*

*v2.0 - 13 Specialized Agent System (Claude Code Optimized)*
