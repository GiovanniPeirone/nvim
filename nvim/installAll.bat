@echo off
setlocal enabledelayedexpansion

:: Verifica si Neovim está instalado
where nvim >nul 2>&1
if errorlevel 1 (
    echo Neovim no está instalado. Por favor instalalo desde https://neovim.io/
    pause
    exit /b
)

:: Verifica si winget está disponible
where winget >nul 2>&1
if errorlevel 1 (
    echo winget no está disponible. Por favor actualiza tu sistema para tener acceso a la Microsoft Store y winget.
    pause
    exit /b
)

echo Instalando herramientas necesarias...

:: Instala Git
winget install --id Git.Git -e --source winget

:: Instala Node.js (necesario para Treesitter y algunos plugins)
winget install --id OpenJS.NodeJS.LTS -e --source winget

:: Instala Python (para Pyright, etc.)
winget install --id Python.Python.3 -e --source winget

:: Instala Go (para gopls)
winget install --id GoLang.Go -e --source winget

:: Instala .NET SDK (para Omnisharp)
winget install --id Microsoft.DotNet.SDK.7 -e --source winget

:: Instala Clang (para clangd)
winget install --id LLVM.LLVM -e --source winget

:: Instala Rust (para rust-analyzer)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | powershell -Command "Invoke-Expression"

:: Crea la carpeta para lazy.nvim si no existe
if not exist "%USERPROFILE%\AppData\Local\nvim\lazy" mkdir "%USERPROFILE%\AppData\Local\nvim\lazy"

:: Clona lazy.nvim
git clone https://github.com/folke/lazy.nvim "%USERPROFILE%\AppData\Local\nvim\lazy\lazy.nvim"

echo Listo. Ahora asegurate de tener tu archivo de configuración en:
echo %USERPROFILE%\AppData\Local\nvim\init.lua

pause
