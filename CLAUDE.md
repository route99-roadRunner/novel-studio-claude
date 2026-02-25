# Novel Studio for Claude Code

14개 전문 에이전트로 구성된 멀티에이전트 소설 창작 시스템.
창작 에이전트(Phase 1-2)는 Prompt Library 패턴, 품질관리 에이전트(Phase 2-3)는 서브에이전트 스폰으로 동작한다.
에이전트 레지스트리·Phase 흐름·스폰 패턴은 `.github/agents/orchestration.md` 참조.

## 언어 라우팅

- 한국어 요청 → `ko-` 접두사 에이전트 사용
- 영어 요청 → 접두사 없는 에이전트 사용
- Main Writer가 첫 응답에서 언어 선택 확인

## 프로젝트 구조

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

## 파일 기반 작업 규칙

**핵심: 소설 본문은 대화에 출력하지 않는다.** 모든 원고는 파일에 저장, 대화에는 요약만.

| 상황 | 올바른 행동 |
|------|------------|
| 새 화 집필 | 챕터 파일에 직접 작성 (Write 도구) |
| 부분 수정 | Edit 도구로 해당 부분만 교체. 전문 재출력 금지 |
| 전면 개고 | 파일을 읽고 → 수정본을 같은 파일에 덮어쓰기 |
| 설정 참조 | phase1_planning 폴더에서 필요한 파일만 읽기 |
| 수정 완료 보고 | 변경 내용을 2~3줄로 요약하여 대화에 보고 |

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
