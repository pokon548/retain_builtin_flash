@echo off
title 内置 Flash 恢复程序
color 3e

echo 正在验证系统是否满足要求...
if /i "%processor_architecture%"=="AMD64" GOTO check_os
if /i "%PROCESSOR_ARCHITEW6432%"=="AMD64" GOTO check_os
if /i "%processor_architecture%"=="x86" GOTO check_os
GOTO notsupported

:check_os
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" GOTO good
echo 检测到不支持的操作系统...
if "%version%" == "6.3" SET WINVER=8.1
if "%version%" == "6.2" SET WINVER=8
if "%version%" == "6.1" SET WINVER=7
if "%version%" == "6.0" SET WINVER=Vista
SET WINVER=Vista 或更低
GOTO notsupported
rem etc etc
endlocal

:good
echo 正在保证系统文件的完整性...
if exist %windir%\SysWOW64 (
 dism /online /add-package /packagepath:".\cab\Windows10.0-KB4577586-x64.cab"
)else (
 dism /online /add-package /packagepath:".\cab\Windows10.0-KB4577586-x86.cab"
)

echo 正在阻止 Flash 卸载补丁的推送（需要联网，请确保互联网畅通）...
start "title" /b /wait cscript.exe .\utils\HideWindowsUpdate.vbs 4577586

echo 正在解除系统对 Flash 卸载补丁的限制...
powershell -ExecutionPolicy Unrestricted -File "unblock_flash_delete_patch.ps1"

echo 正在卸载 Flash 卸载补丁...
if exist %windir%\SysWOW64 (
 dism /Online /remove-package /packagename:Package_for_KB4577586~31bf3856ad364e35~amd64~~10.0.1.2 /norestart
)else (
 dism /Online /remove-package /packagename:Package_for_KB4577586~31bf3856ad364e35~x86~~10.0.1.2 /norestart
)

echo 正在重新部署内置 Flash...
if exist %windir%\SysWOW64 (
 dism /online /add-package /packagepath:".\cab\Windows10.0-KB4580325-x64.cab"
)else (
 dism /online /add-package /packagepath:".\cab\Windows10.0-KB4580325-x86.cab"
)

mshta vbscript:msgbox("执行完毕。重启以生效。本程序由 pokon548 制作。",64,"内置 Flash 恢复程序")(window.close)
exit

:notsupported
mshta vbscript:msgbox("本应用仅支持 Windows 10 x64 / AMD64 架构的系统。您的系统似乎不符合要求：Windows %WINVER%，基于 %processor_architecture% 架构。因此，程序即将退出。本程序由 pokon548 制作。",16,"Flash 恢复程序")(window.close)
exit
