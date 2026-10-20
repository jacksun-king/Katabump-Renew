## 🚀 katabump 自动续期（GitHub Actions）

这是一个基于 GitHub Actions 的自动化脚本，用于定时登录自动续期[katabump](https://dashboard.katabump.com) 应用。

⚠️ 有cf盾,太垃圾的机房节点可能过不了，建议用稍微干净点的节点,[B2proxy住宅代理](https://www.b2proxy.com/signup?code=0F5133)

━━━━━━━━━━━━━━━━━━━━━━

🔐 Secrets 配置说明

### 单账号

| Secret 名称         | 是否必填 | 说明                                              |
|---------------------|----------|---------------------------------------------------|
| KATABUMP_EMAIL     | ✅ 必填  | katabump 登录邮箱                                    |
| KATABUMP_PASSWORD  | ✅ 必填  | katabump 登录密码                                    | 
| NODE_LINK          | ❌ 可选  | 代理链接，如 vless:// vmess:// tuic:// hysteria2:// anttls:// socks5://|
| TG_BOT_TOKEN       | ❌ 可选  | Telegram Bot Token（用于发送通知）                     |
| TG_CHAT_ID         | ❌ 可选  | Telegram Chat ID（接收通知的用户或群组 ID）              |

### 多账号

多个账号用编号后缀，workflow 会自动检测并逐个续期（每次随机顺序，账号之间间隔 10 分钟）：

| Secret 名称              | 是否必填 | 说明                      |
|--------------------------|----------|---------------------------|
| `KATABUMP_EML_1`         | ✅ 必填  | 账号1 的登录邮箱              |
| `KATABUMP_PWD_1`         | ✅ 必填  | 账号1 的登录密码              |
| `KATABUMP_EML_2`         | ❌ 可选  | 账号2 的登录邮箱（可选）        |
| `KATABUMP_PWD_2`         | ❌ 可选  | 账号2 的登录密码（可选）        |
| `KATABUMP_EML_3`         | ❌ 可选  | 账号3 的登录邮箱（可选）        |
| `KATABUMP_PWD_3`         | ❌ 可选  | 账号3 的登录密码（可选）        |
| `…`                      |         | 最多支持到 `_10`             |

- 账号编号从 1 开始，只配置了 `_1` 就是单账号模式（不需要单独的 `KATABUMP_EMAIL`/`KATABUMP_PASSWORD`）
- 多账号与单账号可并存：单账号 Secrets 作为兜底，多账号优先使用 `KATABUMP_EML_N`/`KATABUMP_PWD_N`
- 每个账号必须同时提供 `EML_N` 和 `PWD_N`，缺一不可（检测以 `PWD_N` 是否存在为准）

━━━━━━━━━━━━━━━━━━━━━━
### 代理格式（确认在v2rayN里使用正常的节点）

`NODE_LINK` 支持以下任意一种代理协议的完整分享链接（不配置则直连）：

- **VLESS**：`vless://uuid@server:port?security=reality&sni=...&type=ws&...`
- **VMess**：`vmess://base64encoded...`
- **Trojan**：`trojan://password@server:port?sni=...&type=ws&...`
- **tuic**：`tuic://uuid:password@server:port...`
- **anytls**：`anytls://uuid@server:port...`
- **hysteria2**：`hysteria2://base64@server:port...`
- **SOCKS5**：`socks5://user:pass@server:port` 或 `socks://user:pass@server:port`

### 注意事项
- 尽量添加一个干净的节点，以免过不了cf盾
- cron时间根据自己的服务到期时间的前一天来修改
