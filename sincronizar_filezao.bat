@echo off
title Filezao - Sincronizando...

:: Caminho do Git que vem com o GitHub Desktop
set GIT="C:\Users\Diogo\AppData\Local\GitHubDesktop\app-3.4.20\resources\app\git\cmd\git.exe"

:: Verificar versões comuns do GitHub Desktop
if not exist %GIT% set GIT="C:\Users\Diogo\AppData\Local\GitHubDesktop\app-3.4.19\resources\app\git\cmd\git.exe"
if not exist %GIT% set GIT="C:\Users\Diogo\AppData\Local\GitHubDesktop\app-3.4.18\resources\app\git\cmd\git.exe"
if not exist %GIT% set GIT="C:\Users\Diogo\AppData\Local\GitHubDesktop\app-3.4.17\resources\app\git\cmd\git.exe"
if not exist %GIT% set GIT="C:\Users\Diogo\AppData\Local\GitHubDesktop\app-3.4.15\resources\app\git\cmd\git.exe"
if not exist %GIT% set GIT="C:\Users\Diogo\AppData\Local\GitHubDesktop\app-3.4.12\resources\app\git\cmd\git.exe"
if not exist %GIT% set GIT="C:\Users\Diogo\AppData\Local\GitHubDesktop\app-3.4.9\resources\app\git\cmd\git.exe"

:: Tentar achar automaticamente
if not exist %GIT% (
    for /d %%i in ("C:\Users\Diogo\AppData\Local\GitHubDesktop\app-*") do (
        if exist "%%i\resources\app\git\cmd\git.exe" (
            set GIT="%%i\resources\app\git\cmd\git.exe"
        )
    )
)

if not exist %GIT% (
    echo.
    echo [ERRO] Git nao encontrado!
    echo Abra o GitHub Desktop e tente novamente.
    echo.
    pause
    exit /b
)

cd /d "C:\Users\Diogo\OneDrive\Documentos\GitHub\filezao"

echo.
echo ========================================
echo   SISTEMA FILEZAO - Sincronizacao
echo ========================================
echo.
echo Verificando alteracoes...

%GIT% add index.html CHANGELOG.md SISTEMA_FILEZAO_README.md 2>nul
%GIT% add *.html *.md 2>nul

%GIT% diff --cached --quiet
if %errorlevel% == 0 (
    echo.
    echo [!] Nenhuma alteracao encontrada.
    echo     Salve o index.html na pasta e tente novamente.
    echo.
    pause
    exit /b
)

echo Enviando para o GitHub...

set "datahora=%date:~0,10% %time:~0,5%"
%GIT% commit -m "Atualizacao %datahora%"
%GIT% push

if %errorlevel% == 0 (
    echo.
    echo ========================================
    echo   SITE ATUALIZADO COM SUCESSO!
    echo   Aguarde 1-2 minutos e recarregue:
    echo   acouguedofilezao.github.io/filezao
    echo ========================================
) else (
    echo.
    echo [ERRO] Falha ao enviar. Verifique sua conexao.
)
echo.
pause
