#!/bin/bash
# hooks/sessionStart.sh
# Claude Code 세션 시작 시 프로젝트 상태를 표시하는 스크립트
#
# Claude Code에서는 Notification 훅으로 등록하거나 수동 실행
# 사용법: bash hooks/sessionStart.sh [project_dir]

set -e

PROJECT_DIR="${1:-$(pwd)}"
STATUS_FILE="$PROJECT_DIR/.novel-studio/status.json"
SUMMARY_FILE="$PROJECT_DIR/session_summary.md"

echo "Novel Studio Session Starting..."
echo "Project: $PROJECT_DIR"
echo ""

# 프로젝트 상태 확인
if [ -f "$STATUS_FILE" ]; then
    echo "프로젝트 상태:"
    if command -v python3 &>/dev/null; then
        python3 -c "
import json, sys
with open('$STATUS_FILE') as f:
    data = json.load(f)
print(f\"  Project: {data.get('project_id', 'unknown')}\")
print(f\"  Phase: {data.get('phase', 'unknown')}\")
print(f\"  Progress: {data.get('progress', 0)}%\")
" 2>/dev/null || echo "  (상태 파일 파싱 실패)"
    else
        cat "$STATUS_FILE" 2>/dev/null
    fi
    echo ""
fi

# 이전 세션 요약 로드
if [ -f "$SUMMARY_FILE" ]; then
    echo "이전 세션 요약:"
    cat "$SUMMARY_FILE"
    echo ""
fi

echo "세션 준비 완료"
