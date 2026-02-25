# Novel Studio for Claude Code — 멀티 에이전트 소설 창작 시스템

> **Claude Code가 코딩 도구일 뿐이라고?** 다시 생각해 보세요.
> **Claude Code는 최고의 소설 창작 스튜디오입니다.**
> 이 저장소를 클론하고, Claude Code를 열고, *"소설 써줘"* 라고 말하세요 — 그게 끝입니다.

**[English README](README.md)**

---

## 개요

Novel Studio는 **14개의 전문 AI 에이전트**가 협업하여 출판급 소설을 창작하는 시스템입니다. **Claude Code** 위에서 네이티브로 동작합니다.

`"소설 써줘"` 한마디면 기획, 집필, 편집, 품질 관리까지 에이전트 팀이 모든 것을 처리합니다.

### 왜 Claude Code인가?

Claude Code는 코딩을 넘어 소설 창작 같은 창의적 워크플로우를 가능하게 하는 에이전트 오케스트레이션 플랫폼입니다:

- **CLAUDE.md 자동 로드** — 프로젝트를 여는 순간 시스템이 활성화
- **`.github/agents/` 규약** — 14개 전문가가 에이전트 파일을 읽어 역할 수행
- **Task 도구** — 서브에이전트 스폰으로 병렬 품질 관리
- **Agent Mode** — 자율적 멀티스텝 실행
- **파일 기반 워크플로우** — 원고는 파일에 저장, 대화 컨텍스트를 절약

### 주요 특징

- **14개 전문 에이전트**: 기획 7개 + 집필 4개 + 품질 관리 3개
- **하이브리드 아키텍처**: Prompt Library 패턴 (창작) + Sub-Agent Spawn (품질관리)
- **컨텍스트 최적화**: CLAUDE.md 최소화, 오케스트레이션 로직은 필요 시만 로드
- **장면별 전문화**: 대화/액션/감정 장면마다 전문 작가 배정
- **이중 언어**: 영어·한국어 에이전트 완전 지원
- **Human-in-the-Loop**: 주요 체크포인트에서만 사용자 승인 (5-7회)
- **검증된 품질**: 91/100점 출판급 소설 생성 (실제 프로젝트)

---

## Quick Start

### 1. 클론 및 이동

```bash
git clone https://github.com/route99-roadRunner/novel-studio-claude.git
cd novel-studio-claude
```

### 2. Claude Code 실행

```bash
claude
```

### 3. 소설 요청

```
"소설 써줘"
```

또는 영어로:

```
"Write me a novel"
```

Main Writer 에이전트가 언어 선택을 확인한 후 전체 프로세스를 안내합니다.

---

## 작동 방식

### 하이브리드 아키텍처

```
Phase 1: 기획 [Prompt Library 패턴]
  → Main Writer가 에이전트 파일을 읽고 각 역할을 순차 수행
  → Story / Character / Setting / Genre / Opening Hook / Pacing

Phase 2: 집필 [Prompt Library] + 품질 검토 [서브에이전트 스폰]
  → 장면 유형별 전문 작가: Dialogue / Action / Emotion / Prose
  → 챕터별: Editorial Team + Feedback Agent 병렬 스폰

Phase 3: 완성 [서브에이전트 스폰]
  → Editorial + Feedback + Research 에이전트 병렬 스폰
  → Main Writer가 리포트를 종합하여 최종 원고 통합
```

### 에이전트 오케스트레이션

```
사용자 → CLAUDE.md (시스템 설정, 자동 로드)
           ↓
         Main Writer (총괄) → .agent.md 파일 읽고 역할 수행
           ↓
         Story + Character + Setting + Genre + Opening Hook + Pacing
           ↓
         Dialogue / Action / Emotion / Prose 전문 작가
           ↓
         Editorial Team + Feedback Agent + Research Agent (서브에이전트 스폰)
```

### 승인 체크포인트

| 체크포인트 | 시점 |
|-----------|------|
| Phase 1 완료 | 기획 문서 검토 |
| 각 챕터 | 챕터 초고 완성 |
| Phase 3 완료 | 최종 원고 완성 |

---

## 에이전트 팀 (14개)

| 단계 | 에이전트 | 역할 |
|------|---------|------|
| **기획** | Main Writer | 프로젝트 총괄 & 품질 관리 |
| | Story Writer | 플롯 구성, 서사 전개 |
| | Character Writer | 인물 창조, 관계도 |
| | Setting Writer | 세계관, 배경 설정 |
| | Genre Specialist | 장르 분석, 트로프 전략 |
| | Opening Hook Specialist | 1화 훅 전략, 독자 유입 설계 |
| | Pacing Manager | 템포 조절, 리듬 관리 |
| **집필** | Dialogue Writer | 대화 장면 전문 |
| | Action Writer | 액션/전투 장면 전문 |
| | Emotion Writer | 감정/내면 묘사 전문 |
| | Prose Writer | 일반 서술 전문 |
| **품질** | Editorial Team | 교정, 교열, 일관성 |
| | Feedback Agent | 독자 관점 평가 (5가지 페르소나) |
| | Research Agent | 고증, 사실 확인 |

모든 에이전트에 영어·한국어(`ko-`) 버전이 있습니다.

---

## 프로젝트 구조

```
novel-studio-claude/
├── CLAUDE.md                          ← 시스템 설정 (자동 로드, ~58줄)
├── .github/agents/                    ← 14개 전문 에이전트 (+ 14개 한국어 버전)
│   ├── main-writer.agent.md
│   ├── story-writer.agent.md
│   ├── ...
│   ├── ko-*.agent.md                 ← 한국어 버전
│   ├── orchestration.md              ← 에이전트 레지스트리 & Phase 흐름 (필요 시 로드)
│   └── examples/                     ← 출력 형식 예시 (필요 시 로드)
├── hooks/                             ← Claude Code 라이프사이클 훅
├── scripts/                           ← 품질 관리 유틸리티
└── projects/                          ← 생성된 소설
    ├── ko/first_love_001/             ← 한국어 데모 프로젝트
    └── love_story_heroes/             ← 영어 데모 프로젝트
```

### 생성되는 소설 구조

```
projects/{language}/{project_name}/
├── phase1_planning/       ← 플롯, 캐릭터, 배경, 장르 문서
├── phase2_chapters/       ← 챕터 초고 & 완성본
├── phase3_final/          ← 통합 원고 + 편집/피드백 리포트
├── notes/
│   ├── session-log.md     ← 세션 작업 기록 (컴팩션 복원용)
│   └── revision-notes.md  ← 수정 이력
└── .novel-studio/
    ├── status.json        ← 진행 상태
    ├── checkpoints/       ← 체크포인트
    └── backups/           ← 자동 백업
```

---

## 컨텍스트 최적화 (v2.2)

과도한 컨텍스트 파일이 에이전트 성능을 저하시킨다는 연구 결과에 기반하여, v2.2에서는 **에이전트별 최소 컨텍스트 원칙**을 적용합니다:

| 컴포넌트 | 전략 |
|---------|------|
| `CLAUDE.md` (매 대화 자동 로드) | ~58줄로 축소 — 필수 규칙만 |
| `orchestration.md` | 에이전트 레지스트리 + Phase 흐름 — Main Writer 필요 시만 로드 |
| `examples/` (3개 파일) | 출력 형식 예시 — 집필 시만 로드 |
| 에이전트 `.md` 파일 | 각 에이전트가 자기 완결적 지시를 포함 |

---

## 데모 프로젝트

### `first_love_001` — 한국어 대학 로맨스
- **위치**: `projects/ko/first_love_001/`
- **품질**: 91/100 (출판급)
- **분량**: 11,900자 / 3챕터

### `love_story_heroes` — 영어 판타지 어드벤처
- **위치**: `projects/love_story_heroes/`
- **특징**: 이중 언어 에이전트 시스템, 복합 장르 기획

---

## 사용 예시

**기본:**
```
"대학 캠퍼스 로맨스 소설 써줘"
```

**상세:**
```
프로젝트명: campus_love
아이디어: 공대생과 인문대생의 첫사랑. 벚꽃 계절 배경.
분량: 3챕터
```

**이어쓰기:**
```
"first_love 프로젝트 이어서 써줘"
```

**재작성:**
```
"Chapter 2를 다시 써줘. 편집 리포트 피드백을 반영해서."
```

---

## 작업 모드

| 모드 | 개입 횟수 | 추천 대상 |
|------|----------|----------|
| **Review** (추천) | 5-7회 | 대부분의 사용자 |
| **Auto** | 3회 | 빠른 프로토타입 |
| **Manual** | 15-20회 | 세밀한 통제 |

---

## 버전 히스토리

| 버전 | 변경 사항 |
|------|----------|
| **v2.2** (현재) | Opening Hook Specialist 추가 (14개 에이전트), 컨텍스트 최적화 (CLAUDE.md -74%), orchestration.md + examples/ 분리, 하이브리드 아키텍처 |
| v2.0 | Claude Code 마이그레이션, 13개 에이전트, 훅 시스템, 이중 언어 지원 |
| v1.0 (베타) | 8개 에이전트, 수동 모드만 |

---

## 기여하기

기여를 환영합니다:
1. `.github/agents/` 에이전트 프로필 추가/개선
2. `scripts/` 품질 스크립트 추가
3. 문서 개선
4. 데모 소설 프로젝트 공유

---

## 라이센스

[MIT License](LICENSE)

---

**Novel Studio for Claude Code — by [route99-roadRunner](https://github.com/route99-roadRunner)**

버전: 2.2 | 상태: Production Ready

*"당신의 이야기를, 우리가 완성합니다."*
