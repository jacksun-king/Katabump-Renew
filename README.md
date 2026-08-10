## 🚀 katabump 自动续期（GitHub Actions 多账号版）

这是一个基于 GitHub Actions 的自动化脚本，支持**多账号**依次续期 [katabump](https://dashboard.katabump.com) 应用，**每个账号间隔 15 分钟**，防止被风控封号。

⚠️ 有 CF 盾，太垃圾的机房节点可能过不了，建议用稍微干净点的节点，[B2proxy住宅代理](https://www.b2proxy.com/signup?code=0F5133)

━━━━━━━━━━━━━━━━━━━━━━

## 🔐 Secrets 配置说明

### 单个账号（兼容旧版）

| Secret 名称         | 是否必填 | 说明                                              |
|---------------------|----------|---------------------------------------------------|
| KATABUMP_EMAIL     | ✅ 必填  | katabump 登录邮箱                                    |
| KATABUMP_PASSWORD  | ✅ 必填  | katabump 登录密码                                    |
| NODE_LINK          | ❌ 可选  | 代理链接，如 vless:// vmess:// tuic:// hysteria2:// |
| TG_BOT_TOKEN       | ❌ 可选  | Telegram Bot Token（用于发送通知）                     |
| TG_CHAT_ID         | ❌ 可选  | Telegram Chat ID（接收通知的用户或群组 ID）              |

### 多账号（推荐）

在 Secrets 中按序号添加多组账号，工作流会自动发现并依次执行，**每个账号间隔 15 分钟**：

| Secret 名称           | 是否必填 | 说明                  |
|-----------------------|----------|-----------------------|
| KATABUMP_EML_1       | ✅ 必填  | 第 1 个账号的邮箱       |
| KATABUMP_PWD_1       | ✅ 必填  | 第 1 个账号的密码       |
| KATABUMP_EML_2       | ❌ 可选  | 第 2 个账号的邮箱       |
| KATABUMP_PWD_2       | ❌ 可选  | 第 2 个账号的密码       |
| KATABUMP_EML_3       | ❌ 可选  | 第 3 个账号的邮箱       |
| KATABUMP_PWD_3       | ❌ 可选  | 第 3 个账号的密码       |
| ...                  | ...     | 依此类推               |
| NODE_LINK            | ❌ 可选  | 代理链接（所有账号共用）  |
| TG_BOT_TOKEN         | ❌ 可选  | Telegram Bot Token     |
| TG_CHAT_ID           | ❌ 可选  | Telegram Chat ID       |

> 注意：账号序号从 `1` 开始连续编号，不要跳号。工作流会自动打乱顺序执行，降低风控特征。

━━━━━━━━━━━━━━━━━━━━━━

## ⏱ 执行流程

1. 工作流触发（定时或手动）
2. 发现所有 `KATABUMP_EML_x` 账号，随机打乱顺序
3. **依次执行每个账号**：
   - 启动浏览器 → 代理 → 登录 → 续期 → Telegram 通知
   - 完成后等待 **15 分钟** → 再执行下一个账号
4. 清理旧工作流记录

━━━━━━━━━━━━━━━━━━━━━━

## 🔗 代理格式（确认在 v2rayN 里使用正常的节点）

`NODE_LINK` 支持以下任意一种代理协议的完整分享链接（不配置则直连）：

- **VLESS**：`vless://uuid@server:port?security=reality&sni=...&type=ws&...`
- **VMess**：`vmess://base64encoded...`
- **Trojan**：`trojan://password@server:port?sni=...&type=ws&...`
- **tuic**：`tuic://uuid:password@server:port...`
- **anytls**：`anytls://uuid@server:port...`
- **hysteria2**：`hysteria2://base64@server:port...`
- **SOCKS5**：`socks5://user:pass@server:port` 或 `socks://user:pass@server:port`

## ⚠️ 注意事项

- 尽量添加一个干净的节点，以免过不了 CF 盾
- cron 时间根据自己的服务到期时间的前一天来修改
- 多账号模式下每个账号间隔 **15 分钟**，总运行时间 = 单个账号耗时 × 账号数 + 15 × (账号数 - 1) 分钟
- 如果只想单账号，只用 `KATABUMP_EMAIL` / `KATABUMP_PASSWORD` 即可，与旧版兼容