@echo  off
color b
chcp 65001 >nul
title OptiClub V6.6-BETA "AGGRESSIVE" Performances CFG -https://discord.gg/Np77z4C9qs

echo Checking for Administrative Privelages...
timeout /t 3 /nobreak > NUL
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto GotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:GotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
	
:: Creating Restore Point
echo Creating Restore Point
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f
powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Optimization Club Restore Point' -RestorePointType 'MODIFY_SETTINGS'"
cls
md %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\

echo HKLM, HKCU, HKCR Keys Exported in "Desktop\OptiClub\RegeditBackUpKeys"
REG EXPORT HKLM %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\HKLM.reg
REG EXPORT HKCU %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\HKCU.reg
REG EXPORT HKCR %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\HKCR.reg

md %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\DriversCurrentConfig

reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\DriversCurrentConfig\Enum.reg
reg export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\DriversCurrentConfig\CurrentControlSet.reg
reg export "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001" %UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\DriversCurrentConfig\ControlSet001.reg
timeout /t 2 /nobreak > NUL

start %windir%\explorer.exe "%UserProfile%\Desktop\OptiClub\RegeditBackUpKeys\"
md %UserProfile%\Desktop\OptiClub\FSO

echo Exporting Current FSO Regedit Keys to "\Desktop\OptiClub\FSO"
REG EXPORT HKEY_CURRENT_USER\System\GameConfigStore\ %UserProfile%\Desktop\OptiClub\FSO\FSO.reg
	
	
	
pause

echo this will disable a lot of services so make sure to enable again what you need.

echo Disabling Tasks
timeout /t 1 /nobreak > NUL
echo Xbox Tasks
timeout /t 1 /nobreak > NUL
schtasks /end /tn "\Microsoft\XblGameSave\XblGameSaveTask"
schtasks /change /tn "\Microsoft\XblGameSave\XblGameSaveTask" /disable
schtasks /end /tn "\Microsoft\XblGameSave\XblGameSaveTaskLogon"
schtasks /change /tn "\Microsoft\XblGameSave\XblGameSaveTaskLogon" /disable
timeout /t 1 /nobreak > NUL
echo Done!
timeout /t 1 /nobreak > NUL
echo Other Tasks
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /end /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader"
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
schtasks /change /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\StartupAppTask"
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /disable"
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /disable
schtasks /end /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
schtasks /change /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver" /disable
schtasks /end /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor"
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyMonitor" /disable
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh"
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyRefresh" /disable
schtasks /end /tn "\Microsoft\Windows\Shell\FamilySafetyUpload"
schtasks /change /tn "\Microsoft\Windows\Shell\FamilySafetyUpload" /disable
schtasks /end /tn "\Microsoft\Windows\Autochk\Proxy"
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable
schtasks /end /tn "\Microsoft\Windows\Maintenance\WinSAT"
schtasks /change /tn "\Microsoft\Windows\Maintenance\WinSAT" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\AitAgent"
schtasks /change /tn "\Microsoft\Windows\Application Experience\AitAgent" /disable
schtasks /end /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable
schtasks /end /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /end /tn "\Microsoft\Windows\DiskFootprint\Diagnostics"
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\Diagnostics" /disable
schtasks /end /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)"
schtasks /change /tn "\Microsoft\Windows\FileHistory\File History (maintenance mode)" /disable
schtasks /end /tn "\Microsoft\Windows\PI\Sqm-Tasks"
schtasks /change /tn "\Microsoft\Windows\PI\Sqm-Tasks" /disable
schtasks /end /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo"
schtasks /change /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /disable
schtasks /end /tn "\Microsoft\Windows\AppID\SmartScreenSpecific"
schtasks /change /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /disable
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\Automatic App Update" /Disable
schtasks /Change /TN "\Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
schtasks /Change /TN "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
schtasks /end /tn "\Microsoft\Windows\HelloFace\FODCleanupTask"
schtasks /change /tn "\Microsoft\Windows\HelloFace\FODCleanupTask" /disable
schtasks /end /tn "\Microsoft\Windows\Feedback\Siuf\DmClient"
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClient" /disable
schtasks /end /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /disable
schtasks /end /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
schtasks /change /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /disable
schtasks /end /tn "\Microsoft\Windows\Device Information\Device"
schtasks /change /tn "\Microsoft\Windows\Device Information\Device" /disable
schtasks /end /tn "\Microsoft\Windows\Device Information\Device User"
schtasks /change /tn "\Microsoft\Windows\Device Information\Device User" /disable
timeout /t 1 /nobreak > NUL
echo Done!

cls

md %UserProfile%\Desktop\OptiClub\Win32PrioritySeparation\

PowerShell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/All-Win32Priority-Separation-Tweaks.png" -OutFile " %UserProfile%\Desktop\OptiClub\Win32PrioritySeparation\All-Win32Priority-Separation-Tweaks.png"
PowerShell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/All-Win32Priority-Separation-Tweaks-2.png" -OutFile " %UserProfile%\Desktop\OptiClub\Win32PrioritySeparation\All-Win32Priority-Separation-Tweaks-2.png"
PowerShell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/All-Win32Priority-Separation-Tweaks-3.png" -OutFile " %UserProfile%\Desktop\OptiClub\Win32PrioritySeparation\All-Win32Priority-Separation-Tweaks-3.png"
PowerShell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Recommended-Win32Priority-Separation-Tweak.png" -OutFile " %UserProfile%\Desktop\OptiClub\Win32PrioritySeparation\Recommended-Win32Priority-Separation-Tweak.png"

start %windir%\explorer.exe "%UserProfile%\Desktop\OptiClub\Win32PrioritySeparation\"

echo Adding Win32Priority Separation Tweaks (Default value is "2", new one is "2")
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "2" /f
timeout /t 1 /nobreak > NUL

echo Enabling MSI-Mode 
for /f %%g in ('wmic path win32_videocontroller get PNPDeviceID ^| findstr /L "VEN_"') do (
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d "3" /f
)
timeout /t 1 /nobreak > NUL

echo Enabling Windows Segment Heap
cls
color b
echo Downloading Segment Heap Manager.
md %UserProfile%\Desktop\OptiClub\SegmentHeapManager\
echo CLICK ENABLE
PowerShell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/SegmentHeapManagerv2.6.1.ps1" -OutFile "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapManagerv2.6.1.ps1"
powershell.exe -File "%UserProfile%\Desktop\OptiClub\SegmentHeapManager\SegmentHeapManagerv2.6.1.ps1" 
timeout /t 1 /nobreak > NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrmonitor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrserver.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrwebhelper.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamvr.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrcompositor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrdashboard.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\melonloader.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "RobloxPlayerBeta.exe" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\boneworks.exe" /v "WhoCrashedEx.exe" /t REG_DWORD /d "0x04" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrmonitor.exe" /v "FrontEndHeapDebugOptions" /t REG_DWORD /d "0x04" /f

echo OPTIMIZING PERFORMANCES

cls
echo Changing "Performances" parameters
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "VisualFXSetting" /t REG_DWORD /d 2 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "TaskbarAnimations" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "WindowAnimations" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ThumbnailCacheSize" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FontSmoothing" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableAnimations" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Desktop" /v "VisualFXSetting" /t REG_DWORD /d 2 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v "MenuAnimations" /t REG_DWORD /d 0 /f
REG ADD "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "Max Cached Icons" /t REG_DWORD /d "8192" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "MaxCachedIcons" /t REG_SZ /d "8192" /f
echo ...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TaskbarAnimations" /v DefaultValue /t REG_DWORD /d 0 /f   
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\DragFullWindows" /v DefaultValue /t REG_DWORD /d 0 /f   
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f   
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\MenuAnimation" /v DefaultValue /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects\TooltipAnimation" /v DefaultValue /t REG_DWORD /d 0 /f    
echo disabling smooth scroll (default value = deleted)
REG ADD "HKEY_CURRENT_USER\Control Panel\Desktop" /v "SmoothScroll" /t REG_DWORD /d 0 /f

cls

echo Disabling remnant touches and the shortcut to enable it
reg add "HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "482" /f
timeout /t 1 /nobreak > NUL

cls

echo Enabling Num Lock on Startup (value can be 2147483648 or 80000002 or just 2)
reg add "HKEY_USERS\.DEFAULT\Control Panel\Keyboard" /v "InitialKeyboardIndicators" /t REG_SZ /d "2" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Adaptive Refresh Rate
reg add "HKLM\CurrentControlSet\Control\Power\ModernSleep" /v "AdaptiveRefreshRate" /t REG_DWORD /d "0" /f

cls

echo Enabling ThreadDPC (default value=deleted)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "ThreadDpcEnable" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Core parking via Regedit (Default value = 1, changed to 0)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

echo Changing "Valuemax" value (default 100, changed to 100)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "100" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling GameBarPresenceWriter by regedit
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Deleting/Rename GameBarPresenceWriter so it doesn't start anymore.
taskkill /im GameBarPresenceWriter.exe /f
takeown /f "%WinDir%\System32\GameBarPresenceWriter.exe" /a
icacls "%WinDir%\System32\GameBarPresenceWriter.exe" /grant:r Administrators:F /c
takeown /f "C:\Windows\System32\GameBarPresenceWriter.exe"
move "C:\Windows\System32\GameBarPresenceWriter.exe" "C:\Windows\System32\GameBarPresenceWriter.old"
taskkill /im GameBarPresenceWriter.exe /f
move "C:\Windows\System32\GameBarPresenceWriter.exe" "C:\Windows\System32\GameBarPresenceWriter.OLD"

echo Disable TCP selective acks option for better CPU utilization (Default Value = 0/deleted on fresh install)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameter" /v "SackOpts" /t REG_DWORD /d "0" /f

echo Disabling Tailored Experiences (Default value = 1..? (depends on the W10/11 Version/Tweaks already applied)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f


echo Disabling Transparency effects
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL


echo Enabling GameMode
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f 
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL

echo Disabling Core Integrity (Default Value "1")
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

echo Disabling Gamebar
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement" /v "AllowGameDVR" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
echo disabling BcastDRVUserService (default value = 3)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f 
timeout /t 1 /nobreak > NUL

pause

goto HAGSorVRRGPUSpecEnabler

:HAGSorVRRGPUSpecEnabler
color b
cls

echo %z%Do you have an Nvidia or AMD GPU ?%q%
echo.
echo %i%Nvidia GPU = 1%q%
echo.
echo %i%AMD GPU = 2%q%
echo.
echo %i%Skip = 3%q%
color b
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto NvidiaHAGSActivator
if '%choice%'=='2' goto AMDVRRActivator
if '%choice%'=='3' goto AfterHAGSORVRR

:NvidiaHAGSActivator
cls
color b
echo Enabling Hardware-Accelerated Gpu Scheduling (can cause issues for VR-Games)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchedMode" /t REG_DWORD /d "2" /f

echo "HAGS" apparently cause Stuttering problems ALL OVER windows 11, try it ON/OFF to see, sorry.
timeout /t 1 /nobreak > NUL
echo Done
timeout /t 2 /nobreak > NUL
goto AfterHAGSORVRR

:AMDVRRActivator
cls
color b
echo Enabling Windowed Game Optimizations and VRR for AMD
reg add "HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences" /v "DirectXUserGlobalSettings" /t REG_SZ /d "VRROptimizeEnable=1;SwapEffectUpgradeEnable=1;" /f
timeout /t 1 /nobreak > NUL
echo Done
timeout /t 2 /nobreak > NUL
goto AfterHAGSORVRR

:AfterHAGSORVRR
cls
color b
echo Disabling Windows Insider Experiments
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Windows Tips
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Windows Spotlight
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Shared Experiences
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Bing Search
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Disabling Background Apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo adding IRQ8 Priority (basic value doesn't exist, deleted)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL

cls
echo Adding IRQ0 Priority
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ0Priority" /t REG_DWORD /d 1 /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Adding MenuShowDelay tweak (basic value 1)
reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
echo disabling power Throttling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling GPU Energy Driver
reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Fast Startup
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Sleep Study
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "SleepStudyDisabled" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL

cls

echo Disabling Fault Tolerant Heap (default value "1")
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

echo Setting Game Priorities/MMCSS
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f
timeout /t 1 /nobreak > NUL

echo Disabling Shaking to minimize
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisallowShaking" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL
echo a few more tweaks.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows Media Foundation" /v "EnableFrameServerMode" /t REG_DWORD /d "0" /f 
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "GPU Priority" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Priority" /t REG_DWORD /d "8" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "Scheduling Category" /t REG_SZ /d "Medium" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Low Latency" /v "SFIO Priority" /t REG_SZ /d "High" /f
timeout /t 1 /nobreak > NUL

echo Disabling telemetry
goto DisableTelemetry

:DisableTelemetry
color b
cls
echo %z%Windows 10 or Windows 11 ?%q%
echo.
echo %i%Windows 10 = 1%q%
echo.
echo %i%Windows 11 = 2%q%
color b
set choice=
set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto OOSU
if '%choice%'=='2' goto OOSU

:OOSU
color b

cls

powershell Invoke-WebRequest "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -OutFile "%temp%\OOSU10.exe"
timeout /t 3 /nobreak > NUL
powershell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/Opticlub-V6.6-B.Config.cfg" -OutFile "%temp%\Opticlub-V6.6-B.Config.cfg"
set OOSUPath="%temp%\OOSU10.exe"
set ConfigPath="%temp%\Opticlub-V6.6-B.Config.cfg"

if exist %OOSUPath% (
    if exist %ConfigPath% (
        %OOSUPath% %ConfigPath%
    )
)
start "" /wait "%temp%\OOSU10.exe
echo Done.
timeout /t 5 /nobreak > NUL
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/WPD.exe" -OutFile "%temp%\WPD.exe"
start "" /wait "%temp%\WPD.exe
echo Done.
timeout /t 1 /nobreak > NUL

goto DisableTelemetryContinue

:DisableTelemetryContinue
color b
cls
color b
echo Disable Telemetry Services
echo Disabling Telemetry Services 
sc stop DiagTrack 
sc config DiagTrack start= disabled 
sc stop dmwappushservice 
sc config dmwappushservice start= disabled 
sc stop diagnosticshub.standardcollector.service 
sc config diagnosticshub.standardcollector.service start= disabled 
timeout /t 1 /nobreak > NUL
cls
echo adding NDU Tweak
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f
cls
color b
echo Disabling Delivery Optimization
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DownloadMode" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings" /v "DownloadMode" /t REG_DWORD /d "0" /f 
timeout /t 1 /nobreak > NUL
echo disabling location Tracking
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo adding a few regedit Tweaks
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SlideshowEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d "2" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "IsFeedsAvailable" /t REG_DWORD /d "2" /f
pause
echo Disabling Consumer Features (Windows 10 will not automatically install any games, third-party apps)
echo or application links from the Windows Store for the signed-in user. Some default Apps will be inaccessible (eg. Phone Link)
pause
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvide" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Disabling RPC over Scheduler. (default value = del)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule" /v "DisableRpcOverTcp" /t REG_DWORD /d "00000001" /f
timeout /t 1 /nobreak > NUL
color b
timeout /t 1 /nobreak > NUL
echo Done.

echo Changing Setting Windows Privacy Settings

color b
cls
echo Setting Windows Privacy Settings
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\cellularData\Microsoft.Win32WebViewHost_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Allow" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\gazeInput" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location\Microsoft.Win32WebViewHost_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Prompt" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone\Microsoft.Win32WebViewHost_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Prompt" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation\Microsoft.AccountsControl_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Prompt" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Deny" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "Value" /t REG_SZ /d "Allow" /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam\Microsoft.Win32WebViewHost_cw5n1h2txyewy" /v "Value" /t REG_SZ /d "Allow" /f 
timeout /t 1 /nobreak > NUL

echo Disabling Location Tracking (FROM https://github.com/ChrisTitusTech/winutil/blob/main/config/tweaks.json)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo disabling error reporting
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
timeout /t 1 /nobreak > NUL
echo adding a few regedit Tweaks
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "FeatureManagementEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SlideshowEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo disabling AeroPeek
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\ExtendedComposition" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
color b
timeout /t 1 /nobreak > NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
cls

echo Disable sending Windows Media Player statistics
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d "0" /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "00000000" /f
timeout /t 1 /nobreak > NUL
echo Disabling Edge Diagnostics
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "TabServicesEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AlternateErrorPagesEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d "00000001" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d "00000000" /f
timeout /t 1 /nobreak > NUL
echo Disabling UWP apps / Bloatwares apps to come background
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
cls
echo Disabling WpnService connection to Microsoft (This keeps the service enabled and working, just disable its connection to online servers)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoCloudApplicationNotification" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL

color b
cls
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/OptiClub.V6.6.7-B.pow" -OutFile "%temp%\OptiClub.V6.6.7-B.pow"
pause
powercfg -import "%temp%\OptiClub.V6.6.7-B.pow"
start control powercfg.cpl
echo Successfully Imported Custom Powerplan
pause
timeout /t 3 /nobreak > NUL

echo optimizing Power usage (CPU)

echo disabling Hibernation (Default value : "1") (useless if on desktop PC, good for laptops tho)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "HibernateEnabled" /t REG_DWORD /d "0" /f
powercfg.exe /hibernate off
cls
echo Disabling Power Throttling (Default Value = 1)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Disabling "EnergyEstimationEnabled" (Default Value = 1)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Disabling "EventProcessorEnabled" (Default Value = 1)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f
echo Disabling Core parking via Regedit (Default value = 1, changed to 0)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "Attributes" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Changing "Valuemax" value (default 100, changed to 100)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "100" /f
echo Disabing Core Parking
powershell Invoke-WebRequest "https://coderbag.com/assets/downloads/disable-cpu-core-parking/Unpark-CPU-App.zip" -OutFile "%temp%\Unpark-CPU-App.zip"
powershell -NoProfile Expand-Archive '%temp%\Unpark-CPU-App.zip' -DestinationPath 'C:\UnparkCPUApp\'
start "" /wait "C:\UnparkCPUApp\
echo Disabling Disk-Timeout
powercfg -change -disk-timeout-ac 0


timeout /t 3 /nobreak > NUL

echo Disabling Energy Logging
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
echo Values :
echo "DisableTaggedEnergyLogging" Default Value = 0
echo "TelemetryMaxApplication" Default Value = 250
echo "TelemetryMaxTagPerApplication" Default Value = 50
timeout /t 1 /nobreak > NUL
echo Disabling Standby (CsEnabled+AoAcOverride) (Default Value = Deleted/None)
echo ###INFO###
echo Disabling standby "Prevents Windows from keeping apps in a low-power state, reducing background resource usage."
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL
color b
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender SmartScreen" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableAnimations" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f 
timeout /t 3 /nobreak > NUL
cls
echo adding IRQ8 Priority (because, well.. yeah, IRQ8 Tweak/Priority is an Idea that has been around for like 20 years and will not die, some claim it doesn't do anything, others says it does...)
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /t REG_DWORD /d "1" /f
pause
cls
echo Setting Up "NoLazyMode" (Test value, basic values are non existant so you can just delete those two in case there is a problem)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d "1" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f
timeout /t 3 /nobreak > NUL
echo Setting Game Priorities
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f 
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f 
pause
cls
echo LatencySensitive (Test value, this value doesn't exist normally so you can just delete it if there is a problem)
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d "True" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing" /v "Latency Sensitive" /t REG_SZ /d "True" /f
reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f
timeout /t 1 /nobreak > NUL
cls
echo Adding Games Priority
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/6664447942.bat" -OutFile "%temp%\6664447942.bat"
start "" /wait "%temp%\6664447942.bat
echo Done.
timeout /t 1 /nobreak > NUL
cls
echo Reducing A few apps (Discord, Steam, Wallpaper) Priority
echo Note : If something goes wrong you can just delete the value.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steam.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\steamwebhelper.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Video.UI.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wallpaper32.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wallpaper64.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PhotosApp.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Reducing Svchost Priority (this *MAY* cause problems!)
echo Note : If something goes wrong you can just delete the value.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting up Services Priorities
echo Note : If something goes wrong you can just delete the value.
echo Setting "lsass.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "TrustedInstaller.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "wuauclt.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "TextInputHost.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TextInputHost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "PhotosService.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PhotosService.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Setting "SearchIndexer.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "5" /f
timeout /t 1 /nobreak > NUL
echo Setting "vrmonitor.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrmonitor.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "5" /f
timeout /t 1 /nobreak > NUL
echo Setting "vrdashboard.exe" Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\vrdashboard.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "5" /f
timeout /t 1 /nobreak > NUL
echo Reducing Discord Priority.
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Discord.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Discordptb.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\DiscordCanary.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Disabling msfeed sync.
msfeedssync disable
timeout /t 2 /nobreak > NUL
echo Disabling MicrosoftUpdate Icon in TaskbarAnimations
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "TrayIconVisibility" /t REG_DWORD /d "0" /f
timeout /t 2 /nobreak > NUL
color b
cls

echo PowerShellPackages
echo Removing Unnecessary Powershell Packages
PowerShell -Command "Get-AppxPackage -allusers *bing* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Drawboard PDF* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Getstarted* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Messaging* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *MicrosoftOfficeHub* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Office.OneNote* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *OneNote* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *people* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *SkypeApp* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *solit* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Sway* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *Twitter* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsPhone* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *WindowsSoundRecorder* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage -allusers *windowscommunicationsapps* | Remove-AppxPackage" 
PowerShell -Command "Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage"

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Start\Companions\Microsoft.YourPhone_8wekyb3d8bbwe" /v "IsEnabled" /t REG_DWORD /d "00000000" /f 
   
timeout /t 5 /nobreak > NUL

cls

echo DisableOneDrive
echo Disabling OneDrive
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALL
rd C:\OneDriveTemp /q /s 
rd "%USERPROFILE%\OneDrive" /q /s 
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /q /s 
rd "%PROGRAMDATA%\Microsoft OneDrive" /q /s 
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v "Attributes" /t REG_DWORD /d "0" 
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}\ShellFolder" /f /v "Attributes" /t REG_DWORD /d "0" 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d "1" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d "1" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d "0" /f 
timeout /t 3 /nobreak > NUL

cls

taskkill/im msedge.exe
cd %PROGRAMFILES(X86)%\Microsoft\Edge\Application\1*\Installer
cd C:\Program Files (x86)\Microsoft\Edge\Application\125.0.2535.79\Installer
setup.exe --uninstall --system-level --verbose-logging --force-uninstall
rd /s /q "C:\Program Files (x86)\Microsoft\Edge"
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeCore"
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeUpdate"
rd /s /q "C:\Program Files (x86)\Microsoft\EdgeWebView"
rd /s /q "C:\Program Files (x86)\Microsoft\Temp"
takeown /f "C:\Program Files (x86)\Microsoft"
reg add "HKLM\Software\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d "1" /f 
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/Edge_Removal.bat" -OutFile "%temp%\Edge_Removal.bat"
start "" "%temp%\Edge_Removal.bat
timeout /t 1 /nobreak > NUL
icacls "C:\Program Files (x86)\Microsoft" /deny Everyone:(X)
icacls "C:\Program Files (x86)\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe" /deny Everyone:(X)

del /q "C:\Program Files (x86)\Microsoft\EdgeUpdate\*"
echo Disabling Edge/I.E/WebView can cause problems on games like roblox
timeout /t 3 /nobreak > NUL
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeShoppingAssistantEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "TabServicesEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "AlternateErrorPagesEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageContentEnabled" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageHideDefaultTopSites" /t REG_DWORD /d "00000001" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d "00000000" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d "00000000" /f

cls

echo DisableCortana
echo Disabling Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "0" /f 
Powershell -Command "Get-appxpackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" 
timeout /t 3 /nobreak > NUL

pause

echo Disabling NDU
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 4 /f

cls

echo Enabling Full Screen Optimizations
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DSEBehavior" /t REG_DWORD /d "0" /f 
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f 
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d "0" /f 
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d "0" /f 
reg add "HKCU\SYSTEM\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d "1" /f 

pause

cls

echo Enabling VR-Optimizations
color b
cls
echo Disabling PC Asynchronous Spacewarp for Oculus PCVR
reg.exe add "HKLM\SOFTWARE\Oculus" /v "AswDisabled" /t REG_DWORD /d "1" /f
echo Disabling Link Sharpening
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Oculus\RemoteHeadset" /v "LinkSharpeningEnabled" /t REG_DWORD /d "2" /f
echo disabling HEVC-Codec for LINK
reg.exe add "HKEY_CURRENT_USER\SOFTWARE\Oculus\RemoteHeadset" /v "HEVC" /t REG_DWORD /d "0" /f
echo Adding "numSlices"
reg add "HKEY_CURRENT_USER\SOFTWARE\Oculus\RemoteHeadset" /v "numSlices" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL

echo Downloading Meta Quest Link Optimized In-VR Desktop (No MSAA, Sharp Details, No smoothing)

md %UserProfile%\Documents\Dash\Preferences
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/dash.props" -OutFile "%UserProfile%\Documents\Dash\Preferences\dash.props"
timeout /t 1 /nobreak > NUL

echo, Async (Smooth Motion, In-VR Vsync)
echo To enable it, find "\Steam\config\steamvr.vrsettings, open it and write "motionSmoothing" : enable, To disable it, just write "disable" instead of enable.
echo To enable Async for Meta Quest Link, you need Oculus Debug tools and find "PC Asynchronous Spacewarp" you can enable/disable it from there.
echo Oculus Debug tools is in : "Oculus\Support\oculus-diagnostics\OculusDebugTool.exe"

pause

color b
cls

echo Disabling Services
pause

sc config jhi_service start= disabled
sc stop jhi_service
sc config FvSvc start= disabled
sc config DiagTrack start= disabled
sc config stisvc start= disabled
sc config PhoneSvc start= disabled
sc config SysMain start= disabled
sc config TapiSrv start= disabled
sc config Themes start= disabled
sc config XboxGipSvc start= disabled
sc config LanmanServer start= disabled
sc config DisplayEnhancementService start= disabled
sc config lfsvc start= disabled
sc config RmSvc start= disabled
sc config DPS start= disabled
sc config TabletInputService start= disabled
sc config edgeupdate start= disabled
sc config edgeupdatem start= disabled
sc config Spooler start= disabled
sc config LanmanWorkstation start= disabled
sc config DialogBlockingService start= disabled
sc config RemoteAccess start= disabled
sc config XblAuthManager start= disabled
sc config MsKeyboardFilter start= disabled
sc config DispBrokerDesktopSvc start= disabled
sc config ssh-agent start= disabled
sc config UevAgentService start= disabled
sc config shpamsvc start= disabled
sc config uhssvc start= disabled
sc config AppVClient start= disabled
sc config NetTcpPortSharing start= disabled
sc config ALG start= disabled
sc config RemoteRegistry start= disabled
sc config wlidsvc start= disabled
sc config BTAGService start= disabled
sc config DusmSvc start= disabled

cls

echo others
pause

sc config Fax start= disabled
sc config XboxNetApiSvc start= disabled
sc config WPDBusEnum start= disabled
sc config InstallService start= disabled
sc config FDResPub start= disabled 
sc config WMIRegistrationService start= disabled
sc config WerSvc start= auto
sc config SmsRouter start= disabled 
sc config BITS start= disabled
sc config BDESVC start= disabled
sc config BthAvctpSvc start= disabled
sc config MicrosoftEdgeElevationService start= disabled
sc config OneSyncSvc start= disabled
sc config XblGameSave start= disabled
sc config autotimesvc start= disabled
sc config EventLog start= auto
sc config camsvc start= auto
sc config NvContainerLocalSystem start= disabled
sc config GamingServicesNet start= disabled
sc config GamingServices start= disabled
sc config RasMan start= disabled
sc config PcaSvc start= disabled
sc config ShellHWDetection start= disabled
sc stop ShellHWDetection
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d 4 /f
sc stop DeviceAssociationService
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f
sc config DoSvc start= disabled
sc stop DoSvc
sc config WpnService start= disabled
sc stop WpnService
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d 4 /f
sc stop PimIndexMaintenanceSvc
sc config SENS start= disabled
sc stop SENS
sc config StorSvc start= disabled
sc stop StorSvc
sc config TrkWks start= Auto
sc config wisvc start= disabled
sc stop wisvc
sc config SSDPSRV start= disabled
sc stop SSDPSRV
sc config WSearch start= Auto
sc start WSearch
sc config wisvc start= disabled
sc stop wisvc
sc config wuauserv start= disabled
sc config WaaSMedicSvc start= disabled
sc config EventSystem start= disabled
sc stop EventSystem
sc config SSDPSRV start= disabled
sc stop SSDPSRV
sc config tzautoupdate start= auto
sc config RtkAudioUniversalService start= disabled
sc stop RtkAudioUniversalService
sc config bthserv start= disabled
sc stop bthserv
sc config WbioSrvc start= disabled
sc stop WbioSrvc
sc config W32Time start= auto
sc config GraphicsPerfSvc start= disabled
sc stop GraphicsPerfSvc
sc config SstpSvc start= disabled
sc stop SstpSvc
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DeviceAssociationService" /v "Start" /t REG_DWORD /d 4 /f
sc config DeviceAssociationService start= disabled
sc stop DeviceAssociationService
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\QWAVE" /v "Start" /t REG_DWORD /d 3 /f
sc start QWAVE
sc stop smphost
sc config smphost start= disabled
echo disabling a few other services
sc config MapsBroker start= disabled

cls

echo Windows update disable

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc " /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 4 /f

sc stop WaaSMedicSvc
sc stop wuauserv
sc stop UsoSvc

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wlidsvc" /v "Start" /t REG_DWORD /d 4 /f
sc config wlidsvc start= disabled
sc stop wlidsvc

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v "Start" /t REG_DWORD /d 4 /f
sc config ShellHWDetection start=disabled
sc stop ShellHWDetection

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d 4 /f
sc config PcaSvc start= disabled
sc stop PcaSvc

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "Start" /t REG_DWORD /d 4 /f
sc config TrustedInstaller start= disabled
sc stop TrustedInstaller

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d 4 /f
sc config DsmSvc start= disabled
sc stop DsmSvc

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f
sc config DoSvc start= disabled
sc stop DoSvc

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d 4 /f
sc config WpnService start= disabled
sc stop WpnService

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc " /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d 4 /f
sc stop BITS
sc stop wuauserv
sc stop WaaSMedicSvc
sc stop UsoSvc

sc config WerSvc start= disabled
sc stop WerSvc
sc config WdiSystemHost start= disabled
sc stop WdiSystemHost
sc config TrkWks start= disabled
sc stop TrkWks
sc config TermService start= disabled
sc stop TermService
sc config ShellHWDetection start= disabled
sc stop ShellHWDetection
sc config BITS start= disabled
sc stop BITS
sc config DusmSvc start= disabled
sc stop DusmSvc

sc config OneSyncSvc_47bd5 start= disabled
sc config BcastDVRUserService_47bd5 start= disabled
sc config XboxNetApiSvc start= disabled
sc config XboxGipSvc start= disabled
sc config wuauserv start= disabled
sc config WPDBusEnum start= disabled
sc config WMPNetworkSvc start= disabled
sc config WMIRegistrationService start= disabled
sc config WlanSvc start= disabled
sc config WindscribeService start= disabled
sc config WaaSMedicSvc start= disabled
sc config VSStandardCollectorService150 start= disabled
sc config UsoSvc start= disabled
sc config upnphost start= disabled
sc config UevAgentService start= disabled
sc config Themes start= disabled
sc config TermService start= disabled
sc config TapiSrv start= disabled
sc config TabletInputService start= disabled
sc config SysMain start= disabled
sc config StorSvc start= disabled
sc config stisvc start= disabled
sc config ssh-agent start= disabled
sc config SSDPSRV start= disabled
sc config Spooler start= disabled
sc config SmsRouter start= disabled 
sc config shpamsvc start= disabled
sc config SharedRealitySvc start= disabled
sc config RmSvc start= disabled
sc config RemoteRegistry start= disabled
sc config RemoteAccess start= disabled
sc config PhoneSvc start= disabled
sc config NGS start= disabled
sc config NetTcpPortSharing start= disabled
sc config MsKeyboardFilter start= disabled
sc config MicrosoftEdgeElevationService start= disabled
sc config LGHUBUpdaterService start= disabled
sc config lfsvc start= disabled
sc config LanmanWorkstation start= disabled
sc config LanmanServer start= disabled
sc config jhi_service start= disabled
sc config Intel(R) Platform License Manager Service start= disabled
sc config InstallService start= disabled
sc config GraphicsPerfSvc start= disabled
sc config HvHost start= disabled
sc config FDResPub start= disabled
sc config edgeupdatem start= disabled
sc config edgeupdate start= disabled
sc config DPS start= disabled
sc config DusmSvc start= disabled
sc config DispBrokerDesktopSvc start= disabled
sc config DisplayEnhancementService start= disabled
sc config DialogBlockingService start= disabled
sc config DiagTrack start= disabled
sc config bravem start= disabled
sc config BTAGService start= disabled
sc config brave start= disabled
sc config Bonjour Service start= disabled
sc config BITS start= disabled
sc config autotimesvc start= disabled
sc config AppVClient start= disabled
sc config ALG start= disabled
echo Done! Exiting...
pause
color b