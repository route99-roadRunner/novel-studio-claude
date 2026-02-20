# Novel Studio for Claude Code

Novel Studio는 13개 전문 에이전트로 구성된 멀티에이전트 소설 창작 시스템이다.
**하이브리드 아키텍처**로 동작한다:
- **창작 에이전트 (Phase 1-2)**: Prompt Library 패턴 — `.agent.md` 파일을 읽고 해당 역할 수행
- **품질관리 에이전트 (Phase 2-3)**: 서브에이전트 스폰 — Task 도구로 독립 에이전트 실행

## 에이전트 레지스트리

<agent-registry>

### 기획 단계 (Phase 1) — Prompt Library 패턴
| 역할 | 영문 에이전트 | 한국어 에이전트 |
|------|-------------|---------------|
| 총괄 | `.github/agents/main-writer.agent.md` | `.github/agents/ko-main-writer.agent.md` |
| 플롯 | `.github/agents/story-writer.agent.md` | `.github/agents/ko-story-writer.agent.md` |
| 캐릭터 | `.github/agents/character-writer.agent.md` | `.github/agents/ko-character-writer.agent.md` |
| 세계관 | `.github/agents/setting-writer.agent.md` | `.github/agents/ko-setting-writer.agent.md` |
| 장르 | `.github/agents/genre-specialist.agent.md` | `.github/agents/ko-genre-specialist.agent.md` |
| 페이싱 | `.github/agents/pacing-manager.agent.md` | `.github/agents/ko-pacing-manager.agent.md` |

### 집필 단계 (Phase 2) — Prompt Library 패턴
| 역할 | 영문 에이전트 | 한국어 에이전트 |
|------|-------------|---------------|
| 대화 | `.github/agents/dialogue-writer.agent.md` | `.github/agents/ko-dialogue-writer.agent.md` |
| 액션 | `.github/agents/action-writer.agent.md` | `.github/agents/ko-action-writer.agent.md` |
| 감정 | `.github/agents/emotion-writer.agent.md` | `.github/agents/ko-emotion-writer.agent.md` |
| 서술 | `.github/agents/prose-writer.agent.md` | `.github/agents/ko-prose-writer.agent.md` |

### 품질 관리 (Phase 2-3) — 서브에이전트 스폰
| 역할 | 영문 에이전트 | 한국어 에이전트 | 스폰 방식 |
|------|-------------|---------------|----------|
| 편집 | `.github/agents/editorial-team.agent.md` | `.github/agents/ko-editorial-team.agent.md` | Task(general-purpose) |
| 피드백 | `.github/agents/feedback-agent.agent.md` | `.github/agents/ko-feedback-agent.agent.md` | Task(general-purpose) |
| 리서치 | `.github/agents/research-agent.agent.md` | `.github/agents/ko-research-agent.agent.md` | Task(general-purpose) |

</agent-registry>

## 워크플로우 오케스트레이션

<workflow>

### 하이브리드 아키텍처

#### Prompt Library 패턴 (Phase 1-2 창작)
1. 사용자가 소설 창작을 요청하면 Main Writer 에이전트 파일을 읽고 해당 역할 수행
2. 각 Phase에서 필요한 에이전트 파일을 읽고 해당 역할로 전환하여 작업 수행
3. 작업 완료 후 Main Writer 역할로 복귀
4. 모든 역할 전환은 명시적으로 선언

#### 서브에이전트 스폰 (Phase 2-3 품질관리)
품질관리 에이전트(Editorial Team, Feedback Agent, Research Agent)는 Task 도구로 서브에이전트를 스폰한다.

**이유**:
- 독립적 입력: 완성된 챕터 파일만 받으면 됨
- 신선한 눈 효과: 컨텍스트 리셋 상태가 독자 관점 피드백에 유리
- 메인 컨텍스트 절약: 긴 리포트가 메인을 오염시키지 않음
- 병렬 실행 가능: editorial + feedback + research 동시 실행

**스폰 패턴**:
```
Task(subagent_type="general-purpose") 호출 시 프롬프트에:
1. 해당 .agent.md 파일 내용을 읽도록 지시
2. 대상 챕터/원고 파일 경로 전달
3. 리포트 파일 경로 지정 (phase3_final/editorial_report.md 등)
4. 리포트 작성 후 결과 반환
```

**병렬 실행 예시**:
```
# 3개 품질관리 에이전트를 동시에 스폰
Task 1: Editorial Team → editorial_report.md
Task 2: Feedback Agent → feedback_report.md
Task 3: Research Agent → research_report.md (필요 시)
```

### 언어 라우팅
- 사용자가 한국어로 요청하면 `ko-` 접두사 에이전트 사용
- 사용자가 영어로 요청하면 접두사 없는 에이전트 사용
- Main Writer가 첫 응답에서 언어 선택 확인

### Phase 흐름
```
Phase 1: 기획 [Prompt Library]
  → Main Writer가 Story/Character/Setting/Genre/Pacing 에이전트 역할 순차 수행

Phase 2: 집필 [Prompt Library] + 챕터별 품질 검토 [서브에이전트 스폰]
  → 장면 유형별 Dialogue/Action/Emotion/Prose 에이전트 역할 수행
  → 챕터 완성 시 Editorial + Feedback 서브에이전트 병렬 스폰

Phase 3: 완성 [서브에이전트 스폰]
  → Editorial + Feedback + Research 서브에이전트 병렬 스폰하여 최종 검토
  → Main Writer가 리포트를 종합하여 최종 통합
```

### 승인 체크포인트
사용자에게 승인을 요청할 때 아래 형식 사용:

```
승인 요청:
- 승인: 다음 단계 진행
- 수정: 구체적 수정 요청
- 거절: 새 방향 제시
```

</workflow>

## 프로젝트 구조

```
projects/
  {language}/
    {project_name}/
      phase1_planning/     # 기획 산출물
      phase2_chapters/     # 챕터별 원고
      phase3_final/        # 최종 완성본
```

## 설정 파일

- `config.yaml`: 에이전트 타임아웃, 워크플로우, 출력 형식 설정
- `WORKFLOW_GUIDE.md`: 전체 워크플로우 상세 가이드

## 시작하기

사용자에게 다음과 같이 안내:
```
"소설을 써줘" 또는 "Write me a novel"로 시작하세요.
장르, 아이디어, 분량 등을 알려주시면 최적의 전략을 수립합니다.
```

---
**Version**: 2.0 (Claude Code 최적화)
**System**: 13 Specialized Agent — Hybrid Architecture (Prompt Library + Sub-Agent Spawn)
