@echo off
:: Verifica si está corriendo como administrador
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo ================================
    echo Este script debe ejecutarse como Administrador.
    echo Clic derecho sobre el archivo y selecciona "Ejecutar como administrador".
    echo ================================
    pause
    exit /b
)

echo ========================================
echo LIMPIANDO LOCK FILES DE CHOCOLATEY
echo ========================================
powershell -Command "Remove-Item 'C:\ProgramData\chocolatey\lib\*' -Recurse -Force -ErrorAction SilentlyContinue"

echo ========================================
echo INSTALANDO HERRAMIENTAS PARA NEOVIM + LSP
echo ========================================
choco install -y neovim nodejs python git

echo ========================================
echo VERIFICANDO INSTALACIONES
echo ========================================
where nvim && nvim --version
where node && node -v
where python && python --version
where git && git --version

echo ========================================
echo TODO LISTO. Ahora ejecuta Neovim y corre :Mason
echo para instalar tsserver y pyright.
echo ========================================
pause
