#!/bin/bash
# 确保当前在 self 分支（可选，因脚本在 self 分支运行）
git checkout self
# 切换到 main 分支同步更新
git checkout main
git fetch upstream
git merge upstream/main
git push origin main
git checkout self
# 同步其他分支（非 main）
git fetch origin
for branch in $(git branch -r | grep -v 'origin/main' | grep 'origin/' | sed 's/origin\///'); do
    if ! git show-ref --verify --quiet refs/heads/$branch; then
        git checkout -b "$branch" "origin/$branch"
    else
        git checkout "$branch"
        git pull origin "$branch"
    fi
done
git checkout self  # 最终停留在 self 分支