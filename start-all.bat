@echo off
title Balaji Pan & Cold Drink - Dev Servers
echo ========================================================
echo    BALAJI PAN & COLD DRINK - LOCAL DEVELOPMENT
echo ========================================================
echo.

cd /d "%~dp0"

echo [1/3] Checking MySQL...
netstat -ano | findstr :3306 >nul
if %errorlevel% equ 0 (
    echo [OK] MySQL is already running on port 3306.
) else (
    echo Starting MySQL from C:\xampp\mysql...
    start "MySQL Server" /min "C:\xampp\mysql\bin\mysqld.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" --standalone
    timeout /t 3 >nul
)

echo.
echo [2/3] Starting PHP Backend API on port 8000...
start "Balaji PHP API" /d "%~dp0backend" "C:\xampp\php\php.exe" -S localhost:8000 dev-router.php

echo.
echo [3/3] Starting React Vite Frontend on port 5173...
start "Balaji React Frontend" /d "%~dp0frontend" cmd /c "npm run dev"

echo.
echo ========================================================
echo [READY] Balaji Pan & Cold Drink is launching!
echo.
echo   Customer Shop:  http://localhost:5173
echo   Admin Panel:    http://localhost:5173/admin/login
echo   Backend API:    http://localhost:8000/api/products
echo.
echo   Admin Login Credentials:
echo     Email:    admin@balajipan.com
echo     Password: Admin@123456
echo ========================================================
timeout /t 5 >nul
start http://localhost:5173
