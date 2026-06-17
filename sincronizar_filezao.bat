@echo off
title Filezao - Sincronizando...
cd /d "C:\Filezao"

echo.
echo ========================================
echo   SISTEMA FILEZAO - Sincronizacao
echo ========================================
echo.
echo Verificando alteracoes...

git add index.html CHANGELOG.md SISTEMA_FILEZAO_README.md 2>nul
git add *.html *.md 2>nul

git diff --cached --quiet
if %errorlevel% == 0 (
    echo.
    echo [!] Nenhuma alteracao encontrada.
    echo     Certifique-se de ter salvo o arquivo na pasta C:\Filezao
    echo.
    pause
    exit /b
)

echo.
echo Enviando para o GitHub...
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set dt=%%a
set datahora=%dt:~6,2%/%dt:~4,2%/%dt:~0,4% %dt:~8,2%:%dt:~10,2%

git commit -m "Atualizacao %datahora%"
git push

echo.
echo ========================================
echo   SITE ATUALIZADO COM SUCESSO!
echo   Aguarde 1-2 minutos e recarregue:
echo   acouguedofilezao.github.io/filezao
echo ========================================
echo.
pause
