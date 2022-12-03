#!/usr/bin/env bash
cd "$(dirname $0)/.."
source scripts/env.sh

#WORKSPACE=/Volumes/AV_Workspace/DeepFaceLab_Playground/workspace
python "$DFL_MAIN" extract \
  --input-dir "$WORKSPACE/data_dst/aligned" \
  --output-dir "$WORKSPACE/data_dst/aligned" \
  --detector bless \
  --face-type full_face \
  --image-size 512
conda deactivate
