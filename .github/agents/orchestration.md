# Novel Studio Orchestration

> Main Writer 에이전트가 Phase 전환 시 참조하는 오케스트레이션 문서.
> CLAUDE.md에서 분리하여 필요 시에만 로드한다.

## 에이전트 레지스트리

### 기획 단계 (Phase 1) — Prompt Library 패턴
| 역할 | 영문 에이전트 | 한국어 에이전트 |
|------|-------------|---------------|
| 총괄 | `main-writer.agent.md` | `ko-main-writer.agent.md` |
| 플롯 | `story-writer.agent.md` | `ko-story-writer.agent.md` |
| 캐릭터 | `character-writer.agent.md` | `ko-character-writer.agent.md` |
| 세계관 | `setting-writer.agent.md` | `ko-setting-writer.agent.md` |
| 장르 | `genre-specialist.agent.md` | `ko-genre-specialist.agent.md` |
| 1화 훅 | `opening-hook.agent.md` | `ko-opening-hook.agent.md` |
| 페이싱 | `pacing-manager.agent.md` | `ko-pacing-manager.agent.md` |

### 집필 단계 (Phase 2) — Prompt Library 패턴
| 역할 | 영문 에이전트 | 한국어 에이전트 |
|------|-------------|---------------|
| 대화 | `dialogue-writer.agent.md` | `ko-dialogue-writer.agent.md` |
| 액션 | `action-writer.agent.md` | `ko-action-writer.agent.md` |
| 감정 | `emotion-writer.agent.md` | `ko-emotion-writer.agent.md` |
| 서술 | `prose-writer.agent.md` | `ko-prose-writer.agent.md` |

### 품질 관리 (Phase 2-3) — 서브에이전트 스폰
| 역할 | 영문 에이전트 | 한국어 에이전트 | 스폰 방식 |
|------|-------------|---------------|----------|
| 편집 | `editorial-team.agent.md` | `ko-editorial-team.agent.md` | Task(general-purpose) |
| 피드백 | `feedback-agent.agent.md` | `ko-feedback-agent.agent.md` | Task(general-purpose) |
| 리서치 | `research-agent.agent.md` | `ko-research-agent.agent.md` | Task(general-purpose) |

> 모든 에이전트 파일은 `.github/agents/` 디렉토리에 위치.

## 하이브리드 아키텍처

### Prompt Library 패턴 (Phase 1-2 창작)
1. 사용자가 소설 창작을 요청하면 Main Writer 에이전트 파일을 읽고 해당 역할 수행
2. 각 Phase에서 필요한 에이전트 파일을 읽고 해당 역할로 전환하여 작업 수행
3. 작업 완료 후 Main Writer 역할로 복귀
4. 모든 역할 전환은 명시적으로 선언

### 서브에이전트 스폰 (Phase 2-3 품질관리)
품질관리 에이전트(Editorial Team, Feedback Agent, Research Agent)는 Task 도구로 서브에이전트를 스폰한다.

**이유**: 독립적 입력(완성된 챕터만 필요), 신선한 눈 효과(컨텍스트 리셋), 메인 컨텍스트 절약, 병렬 실행 가능

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
Task 1: Editorial Team → editorial_report.md
Task 2: Feedback Agent → feedback_report.md
Task 3: Research Agent → research_report.md (필요 시)
```

## Phase 흐름

```
Phase 1: 기획 [Prompt Library]
  → Main Writer가 Story/Character/Setting/Genre/Opening Hook/Pacing 에이전트 역할 순차 수행

Phase 2: 집필 [Prompt Library] + 챕터별 품질 검토 [서브에이전트 스폰]
  → 장면 유형별 Dialogue/Action/Emotion/Prose 에이전트 역할 수행
  → 챕터 완성 시 Editorial + Feedback 서브에이전트 병렬 스폰

Phase 3: 완성 [서브에이전트 스폰]
  → Editorial + Feedback + Research 서브에이전트 병렬 스폰하여 최종 검토
  → Main Writer가 리포트를 종합하여 최종 통합
```

## 승인 체크포인트

사용자에게 승인을 요청할 때 아래 형식 사용:

```
승인 요청:
- 승인: 다음 단계 진행
- 수정: 구체적 수정 요청
- 거절: 새 방향 제시
```

## 역할 전환 컨텍스트 관리

- 역할 전환 시 명시적으로 선언하고, 이전 역할의 작업 상태를 `notes/session-log.md`에 기록
- Prompt Library 패턴에서 에이전트 파일을 읽기 전, 현재 작업 진행 상황을 session-log에 저장
- 서브에이전트 스폰 시 메인 컨텍스트에는 결과 요약만 반환 (상세 리포트는 파일로 저장)
- Phase 전환 시 반드시 session-log에 Phase 완료 상태와 다음 작업을 기록

## 작업 공정 순서

### 새 화(에피소드) 집필 공정
```
Step 1 — 사전 확인: 아웃라인에서 해당 화차 줄거리 + 캐릭터 상태 + 직전 화 마지막 장면
Step 2 — 집필: 챕터 파일 생성, 장면 단위 작성, 필요 시 설정 파일 참조
Step 3 — 자체 검토: 일관성 체크, 캐릭터 상태 업데이트, session-log 기록
Step 4 — 보고: 대화에 완료 요약만 출력 (분량, 주요 장면, 특이사항)
```

### 수정(리비전) 공정
```
Step 1 — 수정 범위 파악: 사용자 지시 확인 + 해당 파일에서 수정 대상만 읽기
Step 2 — 수정 실행: Edit 도구로 부분 교체, 전문 재출력 금지
Step 3 — 파급 확인: 후속 화차 영향 확인, 설정 파일 동기화, revision-notes 기록
Step 4 — 보고: "X장의 Y 부분을 Z로 수정 완료" 형태로 간결 보고
```

## 프로젝트 구조

> 새 프로젝트 생성 시 아래 디렉토리 구조를 따른다.

```
projects/{language}/{project_name}/
  phase1_planning/     # 기획 산출물
  phase2_chapters/     # 챕터별 원고
  phase3_final/        # 최종 완성본
  notes/
    session-log.md     # 세션별 작업 기록 (컴팩션 복원용)
    revision-notes.md  # 수정 이력
  .novel-studio/
    status.json        # 프로젝트 상태
    checkpoints/       # 체크포인트 백업
    backups/           # 원고 백업
```

## 컨텍스트 관리 및 컴팩션

**선제적 관리**: 완료 결과는 즉시 파일 저장, session-log.md에 진행 상황 기록.

**컴팩션 복원 절차**:
1. `notes/session-log.md` 읽기 → 마지막 작업 상태 파악
2. 해당 챕터 원고 파일 읽기 → 현재 원고 확인
3. `notes/revision-notes.md` 읽기 → 미완료 수정 사항 확인
4. 사용자에게 상태 보고 후 작업 재개

**세션 로그 형식**: `## 세션: YYYY-MM-DD` → 작업 내용 / 미완료 사항 / 다음 세션 이어갈 것

## 시작하기

```
"소설을 써줘" 또는 "Write me a novel"로 시작하세요.
장르, 아이디어, 분량 등을 알려주시면 최적의 전략을 수립합니다.
```
