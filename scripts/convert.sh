#!/bin/bash
set -e

echo "=== 开始转换 Loyalsoldier 域名规则 ==="

# 下载最新 mihomo（linux amd64）
VERSION="v1.19.3"
echo "下载 mihomo ${VERSION}..."
wget -q https://github.com/MetaCubeX/mihomo/releases/download/${VERSION}/mihomo-linux-amd64-${VERSION}.gz
gunzip mihomo-linux-amd64-${VERSION}.gz
chmod +x mihomo-linux-amd64-${VERSION}
mv mihomo-linux-amd64-${VERSION} mihomo

# 需要转换的域名规则列表（可根据需要增删）
DOMAIN_FILES=(
  "private"
  "direct"
  "gfw"
  "apple"
  "google"
  "proxy"
  "reject"
  "tld-not-cn"
  "icloud"
)

mkdir -p mrs

for name in "${DOMAIN_FILES[@]}"; do
  echo "正在处理: ${name}.txt"
  
  # 下载 Loyalsoldier 官方 txt
  curl -sL "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/${name}.txt" -o "${name}.txt"
  
  # 转换为 mrs
  ./mihomo convert-ruleset domain text "${name}.txt" "mrs/${name}.mrs"
  
  echo "✅ ${name}.mrs 转换完成"
done

# 清理临时文件
rm -f mihomo *.txt

echo "=== 全部转换完成 ==="
ls -lh mrs/
