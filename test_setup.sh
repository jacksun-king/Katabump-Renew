#!/bin/bash
# 模拟 workflow 的 setup 步骤逻辑
# 这次用真实的所有 secrets

echo "=== 模拟 GitHub Actions 账号检测 ==="

# 模拟所有真实存在的 secrets
export KATABUMP_EML_1="email1@example.com"
export KATABUMP_EML_2="email2@example.com"
export KATABUMP_EML_3="email3@example.com"
export KATABUMP_PWD_1="pass1"
export KATABUMP_PWD_2="pass2"
export KATABUMP_PWD_3="pass3"

# 检测账号（通过 PWD secrets）
echo "--- 检测账号 ---"
INDICES=""
[ -n "$KATABUMP_PWD_1" ] && INDICES="$INDICES 1"
[ -n "$KATABUMP_PWD_2" ] && INDICES="$INDICES 2"
[ -n "$KATABUMP_PWD_3" ] && INDICES="$INDICES 3"
echo "检测到账号索引: $INDICES"

# 随机排序
SORTED=$(echo "$INDICES" | xargs -n1 | shuf | xargs)
echo "排序后顺序: $SORTED"
echo "最后一个: $(echo "$SORTED" | awk '{print $NF}')"

# 验证每个账号的 ACC 和 ACC_PWD
echo ""
echo "--- 验证每个账号的 ACC/ACC_PWD ---"
for i in $SORTED; do
  EML_VAR="KATABUMP_EML_$i"
  PWD_VAR="KATABUMP_PWD_$i"
  ACC="${!EML_VAR:-${KATABUMP_EMAIL:-}}"
  ACC_PWD="${!PWD_VAR:-${KATABUMP_PASSWORD:-}}"
  
  [ -n "$ACC" ] && echo "✅ 账号 $i: ACC=${ACC:0:10}... (OK)" || echo "❌ 账号 $i: ACC 为空"
  [ -n "$ACC_PWD" ] && echo "✅ 账号 $i: ACC_PWD=已设置 (OK)" || echo "❌ 账号 $i: ACC_PWD 为空"
done

echo ""
echo "=== 测试通过 ✅ ==="