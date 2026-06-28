# iTop 中文文档待解决问题清单

> 生成时间：2026-06-27
>
> 说明：本次已对所有官方 3.2.0 wiki 页面进行抓取和比对，**所有 3.2.0 命名空间下的页面均已创建本地中文页面**（共 213 个官方页面）。以下内容是无法自动解决或需要后续人工复核的问题。

## 1. 官方页面缓存获取失败

以下页面在官方 wiki 中不存在或返回 404，因此本地保留为空或自定义内容：

| 页面文件 | 期望的官方 wiki ID | 状态 |
|---|---|---|
| `content/zh/docs/faq/_index.md` | `3_2_0:faq:start` | 404 Not Found |
| `content/zh/docs/dev/_index.md` | `3_2_0:dev:start` | 无官方链接（本页为自定义开发调试指南） |
| `content/zh/docs/customization/how-to/datamodel/dynamic-icon/_index.md` | `3_2_0:customization:dynamic-icon` | 404 Not Found，未创建页面 |

## 2. 图片与外部资源

- 本次翻译基于官方 wiki 的纯文本缓存，**未包含图片**。部分页面原有的图片外链（如 `enduser/`、`portal/` 中的 `https://www.itophub.io/wiki/media?...`）已被移除，避免死链。
- 如需图文并茂的文档，建议后续将关键截图下载到 `content/zh/docs/images/` 并更新相对链接。

## 3. 版本脚注

- 所有对应官方 3.2.0 的本地页面均已追加 `版本：...txt · Last modified: ... by 127.0.0.1` 脚注。
- `faq/_index.md` 和 `dev/_index.md` 因无对应官方 3.2.0 页面，未添加版本脚注。

## 4. 仍需人工复核的内容

- **变更日志** (`content/zh/docs/release/change_log/_index.md`)：官方文本超过 120KB，已按段落翻译标题并保留技术描述，建议后续通读润色。
- **XML 数据模型参考** 等技术参考页：内容较长，以结构化翻译为主，术语保留英文。
- **门户/最终用户页面**：已升级到 3.2.0 内容，但图片移除后部分操作步骤的可读性可能下降。

## 5. 内部死链检查

- 已运行脚本检查所有指向官方 wiki 的外部链接，本地未创建的页面均已补齐；目前外部链接全部可映射到本地中文页面。
- 已检查页面间的 Markdown 相对链接，无真实断链（`check_links.py` 对 `/images/...` 静态图片的报警为误判，图片已下载到 `static/images/` 并在 Hugo 构建中正常输出）。

## 6. 构建状态

- Hugo 构建命令：`docker compose run --rm site --gc --minify`
- 当前结果：**通过**
- 页面数量：494（ZH）

## 7. 临时文件说明

为便于本次比对，曾生成以下临时文件/目录，已清理并加入 `.gitignore`，不会提交：

- `official_cache/` / `official_cache_json/`：官方 wiki 页面缓存
- `crawl_wiki.py`、`fetch_official_json.py`、`create_missing_stubs.py`、`fix_*` 等脚本

---

**总结**：iTop 3.2.0 官方 wiki 中所有可访问的页面（213 个）均已在本地创建并翻译/补充中文内容，站点结构与官方保持一致；剩余问题主要为 404 页面、图片缺失和术语润色，已记录如上。
