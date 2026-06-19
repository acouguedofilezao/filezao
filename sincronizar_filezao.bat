@echo off
chcp 65001 >nul
title SISTEMA FILEZAO - Sincronizacao
cd /d "%~dp0"
set "GIT_PAGER=cat"
set "PAGER=cat"

echo ========================================
echo    SISTEMA FILEZAO - Sincronizacao
echo ========================================
echo.
echo Rodando na pasta:
echo   %cd%
echo.

set "GIT="
for /f "delims=" %%i in ('where git 2^>nul') do if not defined GIT set "GIT=%%i"
if defined GIT goto GITOK
for /f "delims=" %%d in ('dir /b /ad /o-n "%LOCALAPPDATA%\GitHubDesktop\app-*" 2^>nul') do if not defined GIT if exist "%LOCALAPPDATA%\GitHubDesktop\%%d\resources\app\git\cmd\git.exe" set "GIT=%LOCALAPPDATA%\GitHubDesktop\%%d\resources\app\git\cmd\git.exe"
:GITOK
if defined GIT goto HAVEGIT
echo [ERRO] Nao encontrei o Git. Abra o GitHub Desktop uma vez e tente de novo.
echo.
pause
exit /b 1
:HAVEGIT

"%GIT%" rev-parse --is-inside-work-tree >nul 2>nul
if not errorlevel 1 goto REPOOK
echo [ERRO] Esta pasta NAO e o repositorio do sistema.
echo Este atalho precisa ficar DENTRO da pasta do GitHub do filezao.
echo.
pause
exit /b 1
:REPOOK

echo Procurando o arquivo baixado (.zip do botao "Baixar tudo") em Downloads...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='SilentlyContinue'; $dl=Join-Path $env:USERPROFILE 'Downloads'; $repo='%cd%'; Add-Type -AssemblyName System.IO.Compression.FileSystem; $zips=Get-ChildItem -LiteralPath $dl -Filter *.zip | Sort-Object LastWriteTime -Descending; $zip=$null; foreach($z in $zips){ try { $a=[System.IO.Compression.ZipFile]::OpenRead($z.FullName); $has=($a.Entries | Where-Object { $_.Name -eq 'index.html' } | Select-Object -First 1); $a.Dispose(); if($has){ $zip=$z; break } } catch {} }; if(-not $zip){ Write-Host '  Nenhum .zip do sistema em Downloads - vou usar o que ja esta na pasta.'; exit }; Write-Host ('  Usando: ' + $zip.Name); $tmp=Join-Path $env:TEMP 'filezao_unzip'; if(Test-Path $tmp){ Remove-Item $tmp -Recurse -Force }; New-Item -ItemType Directory -Path $tmp | Out-Null; try { Expand-Archive -LiteralPath $zip.FullName -DestinationPath $tmp -Force } catch { Write-Host ('  [aviso] falha ao extrair: ' + $_.Exception.Message); exit }; $n=0; Get-ChildItem -Path $tmp -Recurse -File -Include *.html,*.md | ForEach-Object { Copy-Item $_.FullName -Destination $repo -Force; Write-Host ('  atualizado: ' + $_.Name); $n++ }; Remove-Item $tmp -Recurse -Force; Write-Host ('  ' + $n + ' arquivo(s) trazido(s) do .zip.') "
echo.

echo Arquivos nesta pasta - data e hora da ultima alteracao:
for %%f in (index.html tv.html CHANGELOG.md) do call :MOSTRA "%%f"
echo.

echo Procurando alteracoes...
"%GIT%" add -A
echo.
echo O Git detectou estas mudancas:
"%GIT%" --no-pager status -s
echo.

"%GIT%" diff --cached --quiet
if not errorlevel 1 goto NADANOVO
"%GIT%" commit -m "Atualizacao %date% %time%" >nul
echo  -^> Alteracoes salvas. Commit feito.
goto PULL
:NADANOVO
echo  -^> Nenhuma alteracao NOVA para salvar.
echo     Se voce baixou uma versao nova, confira se clicou em "Baixar tudo"
echo     e se o .zip esta na pasta Downloads. Veja as datas dos arquivos acima.
:PULL
echo.

echo Trazendo atualizacoes do GitHub...
"%GIT%" pull --no-rebase --no-edit
if not errorlevel 1 goto PUSH
echo.
echo [ATENCAO] Conflito ao juntar as versoes.
echo Abra o GitHub Desktop, resolva e clique em Push.
echo.
pause
exit /b 1
:PUSH
echo.

echo Enviando para o GitHub...
"%GIT%" push
if not errorlevel 1 goto OK
echo.
echo [ERRO] Falha ao enviar. Veja a mensagem acima.
echo.
pause
exit /b 1
:OK
echo.
echo  ==========================================
echo    Tudo sincronizado!
echo  ==========================================
echo.
echo Ultima versao publicada agora:
"%GIT%" --no-pager log -1 --oneline
echo.
echo - O site atualiza em 1 a 2 minutos.
echo - Na TV / navegador, atualize com Ctrl + F5.
echo.
pause
exit /b 0

:MOSTRA
if exist %1 echo   %~t1  -  %~1
if not exist %1 echo   FALTANDO  -  %~1
exit /b
