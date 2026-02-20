#!/bin/bash
# hooks/preToolUse.sh
# Claude Code PreToolUse 훅 - 파일 수정 전 일관성 체크
#
# Claude Code 훅 인터페이스:
#   - stdin으로 JSON 수신: { "tool_name": "...", "tool_input": {...} }
#   - stdout으로 JSON 응답: { "decision": "allow" } 또는 { "decision": "block", "reason": "..." }
#
# .claude/settings.json에 등록하여 사용

set -e

# stdin에서 JSON 입력 읽기
INPUT=$(cat)

# tool_name과 file_path 추출
TOOL_NAME=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_name',''))" 2>/dev/null || echo "")
FILE_PATH=$(echo "$INPUT" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null || echo "")

# Write/Edit 도구로 캐릭터/설정 파일 수정 시 일관성 체크
if [[ "$TOOL_NAME" == "Write" || "$TOOL_NAME" == "Edit" ]]; then
    if [[ "$FILE_PATH" == *"character"* ]] || [[ "$FILE_PATH" == *"setting"* ]]; then
        # 일관성 체크 스크립트 실행
        if [ -f "scripts/check_consistency.py" ]; then
            RESULT=$(python3 scripts/check_consistency.py "$(pwd)" "$FILE_PATH" 2>&1) || true
            if echo "$RESULT" | grep -q "CONFLICT"; then
                echo "{\"decision\": \"block\", \"reason\": \"일관성 충돌 감지: $RESULT\"}"
                exit 0
            fi
        fi
    fi
fi

# 기본: 허용
echo "{\"decision\": \"allow\"}"
