#!/bin/bash
# hooks/errorOccurred.sh
# 오류 발생 시 로깅 및 처리
#
# Claude Code에는 직접적인 errorOccurred 훅 이벤트가 없음.
# 이 스크립트는 다른 훅이나 스크립트에서 오류 발생 시 호출하는 유틸리티.
# 사용법: bash hooks/errorOccurred.sh [project_dir] [error_type] [error_msg]

set -e

PROJECT_DIR="${1:-$(pwd)}"
ERROR_TYPE="${2:-unknown}"
ERROR_MSG="${3:-No message}"

echo "Error Occurred: $ERROR_TYPE"
echo "  Message: $ERROR_MSG"

# 에러 로그 저장
ERROR_LOG="$PROJECT_DIR/.novel-studio/errors.log"
mkdir -p "$(dirname "$ERROR_LOG")"
echo "[$(date)] $ERROR_TYPE: $ERROR_MSG" >> "$ERROR_LOG"

# 에러 타입별 처리
case "$ERROR_TYPE" in
    "quality_failure")
        echo "  품질 기준 미달 → 재작성 필요"
        ;;
    "consistency_conflict")
        echo "  설정 충돌 감지 → 수동 해결 필요"
        ;;
    *)
        echo "  로그 기록 완료"
        ;;
esac

echo "에러 로그: $ERROR_LOG"
