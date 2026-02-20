#!/bin/bash
# hooks/postToolUse.sh
# Claude Code PostToolUse 훅 - 작업 완료 후 자동 처리
#
# Claude Code 훅 인터페이스:
#   - stdin으로 JSON 수신: { "tool_name": "...", "tool_input": {...}, "tool_output": "..." }
#   - stdout 출력은 로그 목적 (차단 불가)
#
# .claude/settings.json에 등록하여 사용

set -e

# stdin에서 JSON 입력 읽기
INPUT=$(cat)

# tool_name과 file_path 추출
TOOL_NAME=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_name',''))" 2>/dev/null || echo "")
FILE_PATH=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null || echo "")

# Write/Edit로 챕터 파일 작성 완료 시
if [[ "$TOOL_NAME" == "Write" || "$TOOL_NAME" == "Edit" ]]; then
    if [[ "$FILE_PATH" == *"chapter"*.md ]]; then
        # 1. 맞춤법 검사
        if [ -f "scripts/spell_check.py" ]; then
            python3 scripts/spell_check.py "$FILE_PATH" 2>/dev/null || true
        fi

        # 2. 가독성 분석
        if [ -f "scripts/readability.py" ]; then
            python3 scripts/readability.py "$FILE_PATH" 2>/dev/null || true
        fi

        # 3. 백업
        PROJECT_DIR=$(dirname "$(dirname "$FILE_PATH")" 2>/dev/null || echo ".")
        BACKUP_DIR="$PROJECT_DIR/.novel-studio/backups"
        if [ -d "$PROJECT_DIR" ]; then
            mkdir -p "$BACKUP_DIR"
            TIMESTAMP=$(date +%Y%m%d_%H%M%S)
            BASENAME=$(basename "$FILE_PATH" .md)
            cp "$FILE_PATH" "$BACKUP_DIR/${BASENAME}_${TIMESTAMP}.md" 2>/dev/null || true
        fi
    fi
fi

# 상태 업데이트
if [ -f "scripts/update_status.py" ] && [ -n "$FILE_PATH" ]; then
    PROJECT_DIR=$(dirname "$(dirname "$FILE_PATH")" 2>/dev/null || echo ".")
    python3 scripts/update_status.py "$PROJECT_DIR" "$TOOL_NAME" "$FILE_PATH" 2>/dev/null || true
fi
