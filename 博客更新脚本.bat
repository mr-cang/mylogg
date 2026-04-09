@echo off
chcp 65001 >nul
title Git 更新检测工具

echo ==========================
echo 🚀 开始更新...
echo ==========================

:: 获取变更文件列表
set changedFiles=
for /f "delims=" %%i in ('git status --porcelain') do (
    set changedFiles=1
)

:: 判断是否有改动
if not defined changedFiles (
    echo ⚠️ 没有任何更新内容
    pause
    exit /b
)

echo.
echo 📂 本次将更新以下文件：
git status --short

:: 提交
git add .
git commit -m "auto update" >nul 2>&1

if %errorlevel% neq 0 (
    echo.
    echo ❌ 提交失败！
    pause
    exit /b
)

:: 推送
git push >nul 2>&1

if %errorlevel% neq 0 (
    echo.
    echo ❌ 推送失败！（GitHub 未更新）
    pause
    exit /b
)

echo.
echo ==========================
echo ✅ 更新成功！
echo ==========================
echo ✔ 已成功推送到 GitHub
echo ✔ Vercel 将自动部署

echo.
echo 📦 本次更新文件：
git status --short

echo ==========================
pause