@echo off
chcp 65001 >nul
title SISTEMA FILEZAO - Sincronizacao
cd /d "%~dp0"

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

echo Arquivos nesta pasta - data e hora da ultima alteracao:
for %%f in (index.html tv.html CHANGELOG.md) do call :MOSTRA "%%f"
echo.

echo Procurando alteracoes...
"%GIT%" add -A
echo.
echo O Git detectou estas mudancas:
"%GIT%" status -s
echo.

"%GIT%" diff --cached --quiet
if not errorlevel 1 goto NADANOVO
"%GIT%" commit -m "Atualizacao %date% %time%" >nul
echo  -^> Alteracoes salvas. Commit feito.
goto PULL
:NADANOVO
echo  -^> Nenhuma alteracao NOVA nesta pasta para salvar.
echo     Se voce esperava enviar uma versao nova, ela provavelmente
echo     NAO foi colada nesta pasta. Veja as datas dos arquivos acima.
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
"%GIT%" log -1 --oneline
echo.
echo - O site atualiza em 1 a 2 minutos.
echo - No navegador, atualize com Ctrl + F5.
echo - Confira o Atualizado no rodape do sistema: se a hora for recente, subiu.
echo.
echo Se acima apareceu Nenhuma alteracao NOVA, cole os arquivos novos
echo nesta pasta e rode de novo:
echo   %cd%
echo.
pause
exit /b 0

:MOSTRA
if exist %1 echo   %~t1  -  %~1
if not exist %1 echo   FALTANDO  -  %~1
exit /b
