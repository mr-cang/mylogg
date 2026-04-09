@echo off
chcp 65001 >nul
title Git 自动更新工具

echo ==========================
echo 🚀 开始 Git 自动更新...
echo ==========================

:: 检查是否为 Git 仓库
git rev-parse --is-inside-work-tree >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️ 当前目录不是 Git 仓库，正在初始化...
    git init
)

:: 检查是否有远程
git remote show origin >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️ 未检测到远程仓库，请输入远程 URL:
    set /p remoteURL=远程仓库 URL: 
    git remote add origin %remoteURL%
)

:: 设置 Git 用户信息（避免 initial commit 出错）
git config user.name "mr-cang"
git config user.email "2068518299@qq.com"

:: 判断是否有初始提交
git rev-parse HEAD >nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️ 仓库为空，进行初始提交...
    git add .
    git commit -m "initial commit"
    git push -u origin master
    echo ✅ 初始提交完成，已推送到远程
    pause
    exit /b
)

:: 拉取远程更新
echo 🔄 正在拉取远程更新...
git pull --rebase
if %errorlevel% neq 0 (
    echo ⚠️ 拉取远程更新出现冲突，请手动解决后再运行
    pause
    exit /b
)

:: 提交本地更改
set changedFiles=
for /f "delims=" %%i in ('git status --porcelain') do (
    set changedFiles=1
)
if not defined changedFiles (
    echo ⚠️ 没有任何更新内容
    pause
    exit /b
)

echo 📂 本次将更新以下文件：
git status --short

git add .
git commit -m "auto update"
if %errorlevel% neq 0 (
    echo ❌ 提交失败！
    pause
    exit /b
)

:: 推送
git push
if %errorlevel% neq 0 (
    echo ❌ 推送失败！（GitHub 未更新）
    pause
    exit /b
)

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