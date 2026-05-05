# GitHub 关键规则同步工作流

## 当前定位

本仓库只同步 ZT采购端关键规则、状态、模板、非敏感缺口清单和 HSYOS 导入候选说明。

不做本地文件批量同步。

当前事实源关系：

```text
G盘事实源
→ Codex App 选择关键规则文件
→ GitHub 规则同步仓库
→ Mac / HSYOS 读取候选
```

## 同步范围

允许进入 GitHub 的内容仅限：

- 当前状态说明；
- NEXT_ACTION；
- 当前有效规则；
- ZT采购端有限受控试用规则；
- 4项真实采购执行前缺口保留清单；
- 4项授权非敏感摘要值模板；
- 禁止内容检查清单；
- HSYOS 导入候选说明；
- 非敏感规则类 Markdown / CSV 文件。

不需要同步：

- Windows 本地工作目录；
- G盘完整目录；
- 阶段输出包全集；
- 原始文档；
- 原始订单资料；
- 业务明细资料。

## 禁止进入 GitHub 的内容

- 原始资料；
- 原始 PDF / 图片 / Excel 业务明细；
- SECURE；
- 价格、金额、付款、账号、银行信息；
- `soft_unit_price_source`；
- 系统/数据库导出；
- 主表/总表；
- 正式采购结论；
- 真实供应商下单安排。

## Codex App 工作方式

后续规则更新优先在 Codex App 中完成。

每次只向 GitHub 写入明确允许的关键规则文件，不做目录批量复制。

推荐提交对象：

```text
00_current_state/CURRENT_STATE.md
01_effective_rules/CURRENT_EFFECTIVE_RULES.md
02_next_action/NEXT_ACTION.md
03_procurement_side_rules/ZT采购端有限受控试用规则.md
04_gap_management/4项真实采购执行前缺口保留清单.csv
05_templates/4项授权非敏感摘要值接收模板.csv
06_hsyos_import_candidates/HSYOS导入候选规则说明.md
```

## Mac 使用方式

Mac 只需要读取或克隆本仓库中的规则文件。

不要求 Mac 同步 Windows 本地文件。

## HSYOS 读取建议

HSYOS 后续优先读取：

```text
01_effective_rules/
03_procurement_side_rules/
04_gap_management/
05_templates/
06_hsyos_import_candidates/
```

读取前仍需执行 HSYOS 内部审核，不得直接把 GitHub 仓库当作 HSYOS 正式规则库。
