:: ���ƣ�Windowsͼ������ͼ�������ù���
:: �����ߣ�MMTStudio
:: ������2019��8��28��

@echo off
color 0F
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

echo.
echo ��ӭʹ�� Windowsͼ������ͼ����������������
call :ColorText 0F "��ע���ֺ� "
call :ColorText 0A "MMTSTUDIO"
call :ColorText 0F " ������������Ĺ����䣡"
echo.
echo.

:: @echo off
set iconcache=%localappdata%\IconCache.db
set iconcache_x=%localappdata%\Microsoft\Windows\Explorer\iconcache_*
set thumbcache_x=%localappdata%\Microsoft\Windows\Explorer\thumbcache_*

echo ע�⣺
call :ColorText 0E "1.���Թ���Ա�û����б����������"
echo.
call :ColorText 0E "2.��������ʱ�ر��ļ���Դ��������������ػ����ļ�"
echo.
call :ColorText 0E "3.Ϊ��ȫ����ͼ�껺�棬ǿ�ҽ��鱣�����д򿪵Ĺ��������˳���������Ӧ��"
echo.

::echo.
::echo ����ʱ�ر��ļ���Դ��������ɾ�������ļ�IconCache.db
::echo.
::echo Ϊ��ȫ����ͼ�껺�棬�뱣�����д򿪵��ĵ������˳�����Ӧ��
::echo ���֮�����������
::echo.
::call :ColorText 0F "�������������һ������..."
echo.
pause
echo.
If exist "%iconcache%" goto delete
echo.
echo ͼ�껺���ļ�%localappdata%\IconCache.db�ѱ�����
echo. 
If exist "%iconcache_x%" goto delete
echo.
echo ͼ�껺���ļ�%localappdata%\Microsoft\Windows\Explorer\IconCache_*.db�ѱ�����
echo.
If exist "%thumbcache_x%" goto delete
echo.
echo ����ͼ�����ļ�%localappdata%\Microsoft\Windows\Explorer\ThumbCache_*.db�ѱ�����
echo.
exit /B

:delete
echo.
echo ��ʼ����ͼ�������ͼ�����ļ�...
echo.
ie4uinit.exe -show
taskkill /IM explorer.exe /F 
If exist del /A /F /Q "%iconcache%"
If exist del /A /F /Q "%iconcache_x%"
If exist del /A /F /Q "%thumbcache_x%"
start explorer.exe
echo.
echo ͼ�������ͼ�����ļ��ѱ�����.
goto restart


:restart
echo.
echo.
echo ��Ҫ�������������ͼ�������ͼ������ؽ�.
echo.
CHOICE /C:YN /M "��������������Y:������������,N:�ݲ��������� "
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
