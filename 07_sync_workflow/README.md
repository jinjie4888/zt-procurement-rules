# Windows / Mac / HSYOS 同步工作流

## 当前定位

本仓库用于同步 ZT采购端规则、文档、模板、非敏感缺口清单和 HSYOS 导入候选材料。

当前事实源关系：

```text
G盘事实源
→ Windows 本地 Git 仓库
→ GitHub
→ Mac / HSYOS 读取候选
```

## Windows 端推荐目录

```text
D:\HSYFLORAL\github-sync\zt-procurement-rules
```

## Mac 端推荐目录

```text
~/HSYFLORAL/github-sync/zt-procurement-rules
```

## Windows 常用命令

首次克隆：

```powershell
mkdir D:\HSYFLORAL\github-sync
cd D:\HSYFLORAL\github-sync
git clone git@github.com:jinjie4888/zt-procurement-rules.git
cd zt-procurement-rules
```

如果 SSH 未配置，可使用 HTTPS：

```powershell
git clone https://github.com/jinjie4888/zt-procurement-rules.git
```

提交更新：

```powershell
cd D:\HSYFLORAL\github-sync\zt-procurement-rules
git status
git add .
git commit -m "Update ZT procurement rules"
git push
```

## Mac 常用命令

首次克隆：

```bash
mkdir -p ~/HSYFLORAL/github-sync
cd ~/HSYFLORAL/github-sync
git clone git@github.com:jinjie4888/zt-procurement-rules.git
cd zt-procurement-rules
```

拉取更新：

```bash
cd ~/HSYFLORAL/github-sync/zt-procurement-rules
git pull
```

## 同步原则

允许同步：

- 当前状态；
- NEXT_ACTION；
- 当前有效规则；
- ZT采购端有限受控试用规则；
- 4项真实采购执行前缺口保留清单；
- 4项授权非敏感摘要值模板；
- HSYOS 导入候选说明；
- 非敏感阶段收口文档。

禁止同步：

- 原始资料；
- 原始 PDF / 图片 / Excel 业务明细；
- SECURE；
- 价格、金额、付款、账号、银行信息；
- `soft_unit_price_source`；
- 系统/数据库导出；
- 主表/总表；
- 正式采购结论；
- 真实供应商下单安排。

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
