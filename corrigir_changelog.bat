@echo off
chcp 65001 >nul
title Corrigir conflito do CHANGELOG - Filezao
setlocal

cd /d "C:\Users\Diogo\OneDrive\Documentos\GitHub\filezao"
if errorlevel 1 (
  echo Nao encontrei a pasta do projeto.
  pause & exit /b
)

rem ---- localizar o git que vem com o GitHub Desktop ----
set "GIT="
for /d %%D in ("%LocalAppData%\GitHubDesktop\app-*") do if exist "%%D\resources\app\git\cmd\git.exe" set "GIT=%%D\resources\app\git\cmd\git.exe"
if not defined GIT where git >nul 2>nul && set "GIT=git"
if not defined GIT (
  echo Nao achei o git. Abra o GitHub Desktop uma vez e rode de novo.
  pause & exit /b
)
echo Usando o git: %GIT%
echo.

rem ---- configurar o driver de merge "ours" ----
"%GIT%" config merge.ours.driver true

rem ---- dizer ao git: em conflito no CHANGELOG.md, mantenha a versao local ----
> ".gitattributes" echo CHANGELOG.md merge=ours

rem ---- registrar a regra no repositorio ----
"%GIT%" add .gitattributes
"%GIT%" commit -m "Auto-resolver conflitos do CHANGELOG.md (merge=ours)"
"%GIT%" push

echo.
echo ============================================================
echo  Pronto! A partir de agora, quando o CHANGELOG.md "brigar",
echo  o git mantem a sua versao automaticamente. Sem mais aquela
echo  tela de conflito ao sincronizar.
echo ============================================================
echo.
pause
