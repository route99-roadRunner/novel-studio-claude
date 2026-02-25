# Novel Studio — Agent Index

14개 전문 에이전트(EN/KO 쌍)로 구성된 멀티에이전트 소설 창작 시스템.

- **아키텍처**: 창작(Phase 1-2) Prompt Library + 품질관리(Phase 2-3) 서브에이전트 스폰
- **에이전트 파일**: `.github/agents/*.agent.md`
- **오케스트레이션**: `.github/agents/orchestration.md` (레지스트리·Phase 흐름·스폰 패턴)
- **프로젝트 규칙**: `CLAUDE.md` (파일 I/O 규칙·언어 라우팅)

| Phase | 에이전트 (EN / KO) |
|-------|-------------------|
| 기획 | Main Writer, Story Writer, Character Writer, Setting Writer, Genre Specialist, Opening Hook, Pacing Manager |
| 집필 | Dialogue Writer, Action Writer, Emotion Writer, Prose Writer |
| 품질 | Editorial Team, Feedback Agent, Research Agent |

*v2.2 — Context-Optimized Multi-Agent System*
