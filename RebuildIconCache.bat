:: 名称：Windows图标缩略图缓存重置工具
:: 创建者：MMTStudio
:: 创建：2019年8月28日

@echo off
color 0F
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

echo.
echo 欢迎使用 Windows图标缩略图缓存重置批处理工具
call :ColorText 0F "关注快手号 "
call :ColorText 0A "MMTSTUDIO"
call :ColorText 0F " ，不断扩充你的工具箱！"
echo.
echo.

:: @echo off
set iconcache=%localappdata%\IconCache.db
set iconcache_x=%localappdata%\Microsoft\Windows\Explorer\iconcache_*
set thumbcache_x=%localappdata%\Microsoft\Windows\Explorer\thumbcache_*

echo 注意：
call :ColorText 0E "1.请以管理员用户运行本批处理程序"
echo.
call :ColorText 0E "2.本程序将临时关闭文件资源管理器以重置相关缓存文件"
echo.
call :ColorText 0E "3.为完全重置图标缓存，强烈建议保存所有打开的工作，并退出所有其它应用"
echo.

::echo.
::echo 将暂时关闭文件资源管理器以删除缓存文件IconCache.db
::echo.
::echo 为完全重置图标缓存，请保存所有打开的文档，并退出其他应用
::echo 完成之后按任意键继续
::echo.
::call :ColorText 0F "按任意键进行下一步操作..."
echo.
pause
echo.
If exist "%iconcache%" goto delete
echo.
echo 图标缓存文件%localappdata%\IconCache.db已被重置
echo. 
If exist "%iconcache_x%" goto delete
echo.
echo 图标缓存文件%localappdata%\Microsoft\Windows\Explorer\IconCache_*.db已被重置
echo.
If exist "%thumbcache_x%" goto delete
echo.
echo 缩略图缓存文件%localappdata%\Microsoft\Windows\Explorer\ThumbCache_*.db已被重置
echo.
exit /B

:delete
echo.
echo 开始重置图标和缩略图缓存文件...
echo.
ie4uinit.exe -show
taskkill /IM explorer.exe /F 
If exist del /A /F /Q "%iconcache%"
If exist del /A /F /Q "%iconcache_x%"
If exist del /A /F /Q "%thumbcache_x%"
start explorer.exe
echo.
echo 图标和缩略图缓存文件已被重置.
goto restart


:restart
echo.
echo.
echo 需要重启电脑以完成图标和缩略图缓存的重建.
echo.
CHOICE /C:YN /M "现在重启电脑吗？Y:马上重启电脑,N:暂不重启电脑 "
IF ERRORLEVEL 2 goto no
IF ERRORLEVEL 1 goto yes

:yes
shutdown /r /f /t 00

:no
exit /B

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
