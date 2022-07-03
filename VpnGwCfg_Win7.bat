@ECHO OFF&PUSHD %~DP0 &TITLE VPN路由配置

set ifname="ZWGK4VPN"
set net="192.168.101.0"
set mask="255.255.255.0"
set gateway="192.168.101.1"
::route print -4 |findstr "ZWGK4VPN"
color 2C

SET str=""
FOR /F "delims=" %%i IN ('route print -4 ^|findstr %ifname%') do (
	::echo B--%%i
	SET str=%%i
)
::echo C--%str%
if %str% == "" (
	echo "No active VPN found."
	pause>nul
	exit /B
)
::) else (
	::echo D--%str%
::)
set if=""
FOR /f "delims=." %%i IN ("%str%") do (
	::echo E--%%i
	set if=%%i
)
set if=%if: =%

:menu
cls
echo 请确认配置，若有误请先编辑本文件后再运行。
echo ［VPN 名称: %ifname%］ 
echo ［远端网络: %net%］
echo ［远端网关: %gateway%］
echo.
echo ==============================
echo.
echo 输入1，添加VPN路由
echo.
echo 输入2，删除VPN路由
echo.
echo 输入3，取消
echo.
echo ==============================
echo.
choice /c 123 /n /m "请选择操作:"
if %errorlevel% equ 1 goto setgw
if %errorlevel% equ 2 goto clrgw
if %errorlevel% equ 3 exit /B
pause>nul
goto menu

:setgw
if %if% NEQ "" (
	echo 网口ID为: %if%
	FOR /F "delims=" %%i IN ('route add %net% mask %mask% %gateway% if %if%') do (
		echo %%i
	)
)
pause>nul
exit /B

:clrgw
if %if% NEQ "" (
	echo 网口ID为: %if%
	FOR /F "delims=" %%i IN ('route delete %net%') do (
		echo %%i
	)
)
pause>nul
exit /B
