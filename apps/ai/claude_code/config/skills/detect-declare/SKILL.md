---
name: detect-declare
description: 確保 php 檔案是否都有在開頭宣告 `declare(strict_types=1);`，當使用者需要檢查任何 php 檔案時，可以使用。
---

## 檢查的檔案

若使用者有提供要檢查的資料夾或檔案，則檢查使用者提供的資料夾或檔案。

若使用者未提供則檢查以下檔案：

!`git diff HEAD`

## Instructions

請確保所有 php 檔案都有在開頭宣告 `declare(strict_types=1);`