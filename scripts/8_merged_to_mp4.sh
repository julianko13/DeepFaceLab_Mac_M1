#!/usr/bin/env bash
cd "$(dirname $0)/.."
source scripts/env.sh

python "$DFL_MAIN" videoed video-from-sequence \
  --input-dir "$WORKSPACE/data_dst/merged" \
  --output-file "$WORKSPACE/result.mp4" \
  --reference-file "$WORKSPACE/data_dst.*" \
  --include-audio
conda deactivate
