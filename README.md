# Loyalsoldier Domain Rules → MRS

将 [Loyalsoldier/clash-rules](https://github.com/Loyalsoldier/clash-rules) 的域名规则（txt）自动转换为 mihomo / Clash Meta 可用的 **MRS** 格式，每天自动更新。

## 为什么需要这个仓库？

- Loyalsoldier 的域名规则对中国大陆域名覆盖更准确
- MetaCubeX 的部分规则在实际使用中不够完整
- MRS 格式比 TXT 加载更快、内存占用更低

## 已转换规则

| 规则名 | 对应源文件 | 用途 | 下载地址 |
|--------|------------|------|----------|
| `private.mrs` | `private.txt` | 局域网 / 私有域名 | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/private.mrs) |
| `direct.mrs` | `direct.txt` | 中国大陆域名（直连） | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/direct.mrs) |
| `gfw.mrs` | `gfw.txt` | GFW 列表（需代理） | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/gfw.mrs) |
| `apple.mrs` | `apple.txt` | Apple 服务 | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/apple.mrs) |
| `google.mrs` | `google.txt` | Google 服务 | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/google.mrs) |
| `proxy.mrs` | `proxy.txt` | 代理列表 | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/proxy.mrs) |
| `reject.mrs` | `reject.txt` | 广告 / 拒绝列表 | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/reject.mrs) |
| `tld-not-cn.mrs` | `tld-not-cn.txt` | 非中国大陆顶级域名 | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/tld-not-cn.mrs) |
| `icloud.mrs` | `icloud.txt` | iCloud 服务 | [下载](https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/icloud.mrs) |

## 使用方法

在 mihomo / Clash Meta 配置文件中添加：

```yaml
rule-providers:
  private:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/private.mrs"
    path: ./providers/private.mrs
    interval: 86400

  ChinaDomain:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/direct.mrs"
    path: ./providers/direct.mrs
    interval: 86400

  gfw:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/gfw.mrs"
    path: ./providers/gfw.mrs
    interval: 86400

  apple:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/apple.mrs"
    path: ./providers/apple.mrs
    interval: 86400

  google:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/google.mrs"
    path: ./providers/google.mrs
    interval: 86400

  proxy:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/proxy.mrs"
    path: ./providers/proxy.mrs
    interval: 86400

  reject:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/reject.mrs"
    path: ./providers/reject.mrs
    interval: 86400

  tld-not-cn:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/tld-not-cn.mrs"
    path: ./providers/tld-not-cn.mrs
    interval: 86400

  icloud:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/cfxgy/rules-mrs@release/mrs/icloud.mrs"
    path: ./providers/icloud.mrs
    interval: 86400
```

然后在 `rules` 中按需引用，例如：

```yaml
rules:
  - RULE-SET,private,DIRECT
  - RULE-SET,reject,REJECT
  - RULE-SET,icloud,DIRECT          # 或 PROXY，按个人需求
  - RULE-SET,apple,DIRECT           # 或 PROXY
  - RULE-SET,google,PROXY
  - RULE-SET,gfw,PROXY
  - RULE-SET,proxy,PROXY
  - RULE-SET,ChinaDomain,DIRECT
  - RULE-SET,tld-not-cn,PROXY
  - MATCH,PROXY
```

### 备用加速地址

把链接中的 `cdn.jsdelivr.net/gh` 替换为：

```
https://raw.githubusercontent.com/cfxgy/rules-mrs/release/mrs/文件名.mrs
```

## 自动更新

- 每天北京时间 **03:00** 自动从 Loyalsoldier 拉取最新规则并转换为 MRS
- 支持手动触发（Actions → Run workflow）

## 本地转换方法

```bash
# 下载 mihomo
wget https://github.com/MetaCubeX/mihomo/releases/download/v1.19.3/mihomo-linux-amd64-v1.19.3.gz
gunzip mihomo-linux-amd64-v1.19.3.gz
chmod +x mihomo-linux-amd64-v1.19.3

# 下载源文件并转换（以 direct 为例）
curl -L -o direct.txt "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt"
./mihomo-linux-amd64-v1.19.3 convert-ruleset domain text direct.txt direct.mrs
```

## 致谢

- [Loyalsoldier/clash-rules](https://github.com/Loyalsoldier/clash-rules) — 域名规则来源
- [MetaCubeX/mihomo](https://github.com/MetaCubeX/mihomo) — 转换工具

## License

本仓库仅做格式转换，规则内容版权归原作者所有。
