@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Filezao - Resolver conflito do Git

rem ===== localizar o git embutido do GitHub Desktop =====
set "GIT="
for /d %%D in ("%LOCALAPPDATA%\GitHubDesktop\app-*") do set "GIT=%%D\resources\app\git\cmd\git.exe"
if not exist "%GIT%" set "GIT=git"

echo ============================================================
echo  Resolvendo o conflito mantendo a SUA versao (local).
echo ============================================================
echo.

rem habilita a estrategia "manter o nosso"
"%GIT%" config merge.ours.driver true

rem mantem a versao LOCAL de tudo (resolve qualquer conflito a favor do seu PC)
"%GIT%" checkout HEAD -- . 2>nul
"%GIT%" add -A
"%GIT%" commit --no-edit 2>nul

rem ===== evita conflito futuro nesses arquivos (sempre manter o local) =====
> .gitattributes echo CHANGELOG.md merge=ours
>> .gitattributes echo SISTEMA_FILEZAO_README.md merge=ours
>> .gitattributes echo index.html merge=ours
>> .gitattributes echo areainterna.html merge=ours
>> .gitattributes echo areainterna_bkp.html merge=ours
>> .gitattributes echo areainterna_embreve.html merge=ours
>> .gitattributes echo tv.html merge=ours
"%GIT%" add .gitattributes
"%GIT%" commit -m "git: manter versao local (merge=ours)" 2>nul

echo.
echo Enviando para o GitHub...
"%GIT%" push origin main

echo.
echo ============================================================
echo  PRONTO! Conflito resolvido e configurado para nao repetir.
echo ============================================================
pause
