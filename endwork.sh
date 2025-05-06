#!/bin/bash
# 确保当前在 self 分支（可选，因脚本在 self 分支运行）
git checkout self
# 推送所有非 main 分支
for branch in $(git branch | grep -v 'main'); do
    git checkout "$branch"
    git push origin "$branch"
done
git checkout self  # 最终停留在 self 分支