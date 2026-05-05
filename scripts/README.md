# scripts

## `sync_gdrive_rules_to_repo.ps1`

Windows 端安全同步脚本。

用途：从 G盘事实源复制一组明确允许的控制层/规则层文件到本地 Git 仓库，便于提交到 GitHub 并在 Mac 或 HSYOS 候选读取端同步。

运行位置：本地仓库根目录。

```powershell
cd D:\HSYFLORAL\github-sync\zt-procurement-rules
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\sync_gdrive_rules_to_repo.ps1
```

运行后必须检查：

```powershell
git status
git diff --stat
```

确认没有原始资料、SECURE、价格、金额、付款、账号、银行信息、主表/总表、正式结果后，才允许提交。
