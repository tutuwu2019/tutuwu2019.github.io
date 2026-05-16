#!/bin/bash
# 发布博客：构建 Hugo 并推送到 GitHub Pages
set -e

BLOG_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$BLOG_DIR")"

echo "==> 构建 Hugo 站点..."
cd "$BLOG_DIR"
/usr/local/bin/hugo --minify

echo "==> 提交并推送到 GitHub..."
cd "$REPO_DIR"
git add -A
git commit -m "update $(date '+%Y-%m-%d %H:%M')"
git push origin main

echo "==> 完成！网站将在几分钟后更新: https://tutuwu2019.github.io/"
