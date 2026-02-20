# Novel Studio Hooks System (Claude Code)

## 개요

Hooks 시스템은 Novel Studio의 자동화 파이프라인을 구성하는 핵심 컴포넌트입니다.
Claude Code의 훅 인터페이스에 맞게 설계되어 파일 수정 전후에 자동으로 품질 관리를 수행합니다.

---

## Claude Code 훅 등록

`.claude/settings.json`에 훅을 등록하여 사용합니다:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "bash hooks/preToolUse.sh"
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "command": "bash hooks/postToolUse.sh"
      }
    ]
  }
}
```

---

## Hook 유형

### 1. preToolUse.sh (PreToolUse 훅)

**실행 시점**: Claude Code가 Write/Edit 도구를 사용하기 전
**목적**: 캐릭터/설정 파일 수정 시 일관성 검증

**동작**:
- stdin으로 JSON 입력 수신 (`tool_name`, `tool_input`)
- 캐릭터/설정 파일 수정 감지 시 일관성 체크 실행
- 충돌 발견 시 `{"decision": "block"}` 반환하여 수정 차단
- 문제 없으면 `{"decision": "allow"}` 반환

**입출력 형식**:
```
stdin:  { "tool_name": "Write", "tool_input": { "file_path": "..." } }
stdout: { "decision": "allow" }
```

---

### 2. postToolUse.sh (PostToolUse 훅)

**실행 시점**: Claude Code가 Write/Edit 도구 사용 완료 후
**목적**: 자동 검증 및 백업

**동작**:
- 챕터 파일 작성 완료 시:
  - 맞춤법 검사 (spell_check.py)
  - 가독성 분석 (readability.py)
  - 자동 백업 (.novel-studio/backups/)
- 프로젝트 상태 업데이트 (update_status.py)

---

### 3. sessionStart.sh (수동 실행)

**실행 시점**: 세션 시작 시 수동 실행
**목적**: 프로젝트 상태 확인 및 이전 세션 요약 표시

**사용법**:
```bash
bash hooks/sessionStart.sh [project_dir]
```

> Claude Code에는 세션 시작 훅 이벤트가 없으므로 필요 시 수동으로 실행합니다.

---

### 4. errorOccurred.sh (유틸리티)

**실행 시점**: 다른 스크립트에서 오류 발생 시 호출
**목적**: 오류 로깅

**사용법**:
```bash
bash hooks/errorOccurred.sh [project_dir] [error_type] [error_msg]
```

**오류 타입**:
- `quality_failure`: 품질 기준 미달
- `consistency_conflict`: 설정 충돌

---

## 지원 스크립트

### scripts/check_consistency.py
캐릭터/설정 일관성 자동 검증

```bash
python3 scripts/check_consistency.py /path/to/project target_file.md
```

### scripts/spell_check.py
맞춤법 자동 검사 (규칙 기반)

```bash
python3 scripts/spell_check.py chapter_01.md
```

### scripts/readability.py
가독성 분석 (글자 수, 문장 수, 반복 표현 탐지)

```bash
python3 scripts/readability.py chapter_01.md
```

### scripts/update_status.py
프로젝트 상태 자동 업데이트

```bash
python3 scripts/update_status.py /path/to/project write chapter_01.md
```

---

## 설치 및 설정

### 1. 실행 권한 부여
```bash
chmod +x hooks/*.sh
chmod +x scripts/*.py
```

### 2. Python 의존성
```bash
python3 --version  # 3.8 이상 권장
# 추가 패키지 불필요
```

### 3. Claude Code 훅 등록
`.claude/settings.json`에 위의 훅 설정을 추가합니다.

---

## 테스트

### preToolUse 테스트
```bash
echo '{"tool_name":"Write","tool_input":{"file_path":"character_profiles.md"}}' | bash hooks/preToolUse.sh
```

### postToolUse 테스트
```bash
echo '{"tool_name":"Write","tool_input":{"file_path":"chapter_01.md"}}' | bash hooks/postToolUse.sh
```

### sessionStart 테스트
```bash
mkdir -p test_project/.novel-studio
echo '{"project_id":"test","phase":"phase1","progress":0}' > test_project/.novel-studio/status.json
bash hooks/sessionStart.sh test_project
```

---

## 효과 측정

### Before (수동)
- 일관성 체크: 수동
- 맞춤법 검사: 수동
- 백업: 수동

### After (Claude Code Hooks)
- 일관성 체크: **자동** (PreToolUse)
- 맞춤법 검사: **자동** (PostToolUse)
- 백업: **자동** (PostToolUse)
- 상태 추적: **자동** (PostToolUse)

---

**작성자**: Novel Studio Development Team
**최종 업데이트**: 2026-02-20
**버전**: 2.0 (Claude Code 최적화)
