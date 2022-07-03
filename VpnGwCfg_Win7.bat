@ECHO OFF&PUSHD %~DP0 &TITLE VPN·������

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
echo ��ȷ�����ã����������ȱ༭���ļ��������С�
echo ��VPN ����: %ifname%�� 
echo ��Զ������: %net%��
echo ��Զ������: %gateway%��
echo.
echo ==============================
echo.
echo ����1�����VPN·��
echo.
echo ����2��ɾ��VPN·��
echo.
echo ����3��ȡ��
echo.
echo ==============================
echo.
choice /c 123 /n /m "��ѡ�����:"
if %errorlevel% equ 1 goto setgw
if %errorlevel% equ 2 goto clrgw
if %errorlevel% equ 3 exit /B
pause>nul
goto menu

:setgw
if %if% NEQ "" (
	echo ����IDΪ: %if%
	FOR /F "delims=" %%i IN ('route add %net% mask %mask% %gateway% if %if%') do (
		echo %%i
	)
)
pause>nul
exit /B

:clrgw
if %if% NEQ "" (
	echo ����IDΪ: %if%
	FOR /F "delims=" %%i IN ('route delete %net%') do (
		echo %%i
	)
)
pause>nul
exit /B
