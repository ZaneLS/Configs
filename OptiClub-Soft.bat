@echo  off
color b
chcp 65001 >nul
title OptiClub V6.6-BETA "Soft" CFG -https://discord.gg/Np77z4C9qs

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


echo Adding Win32Priority Separation Tweaks (Default value is "2", new one is "2")
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "2" /f
timeout /t 1 /nobreak > NUL

echo Enabling MSI-Mode 
for /f %%g in ('wmic path win32_videocontroller get PNPDeviceID ^| findstr /L "VEN_"') do (
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Enum\%%g\Device Parameters\Interrupt Management\Affinity Policy" /v "DevicePriority" /t REG_DWORD /d "3" /f
)

echo Enabling PerformancesMode
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "EnablePerformanceMode" /t REG_DWORD /d 0x00000001 /f
echo Disabling Overlays (Default Value = 0, New Value = 0)
::Why, it can causes weird screen (on multi-monitor setups) flickering or even black screen errors, this seems to be "specific" but disabled in case)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DisableOverlays" /t REG_DWORD /d 0 /f
echo Disabling Prefetcher
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetch" /t REG_DWORD /d "0" /f
reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f
echo Disabling Sysmain
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d "4" /f
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

echo Disabling Tailored Experiences (Default value = 1..? (depends on the W10/11 Version/Tweaks already applied)
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f

timeout /t 1 /nobreak > NUL
cls

timeout /t 1 /nobreak > NUL
cls
color b
echo Disabling Transparency effects
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

cls
color b
echo Enabling GameMode
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d "1" /f 
reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d "1" /f 
timeout /t 1 /nobreak > NUL
cls

echo Disabling Core Integrity (Default Value "1")
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f
timeout /t 1 /nobreak > NUL

Goto HAGSorVRRGPUSpecEnabler

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
reg add "HKEY_CURRENT_USER\Software\Microsoft\DirectX\GraphicsSettings" /v "SwapEffectUpgradeCache" /t REG_DWORD /d 1 /f
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
echo Done!

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
powershell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/MSI_UTIL_V3/refs/heads/main/OptiClub-V6.6.7-B.pow" -OutFile "%temp%\OptiClub-V6.6.7-B.pow"
pause
powercfg -import "%temp%\OptiClub-V6.6.7-B.pow"
powercfg -change -disk-timeout-ac 0
start control powercfg.cpl
echo Successfully Imported Custom Powerplan

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

echo fully disabling SmartScreen.
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender SmartScreen" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f
timeout /t 1 /nobreak > NUL

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableAnimations" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "10" /f 
timeout /t 3 /nobreak > NUL
cls
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
echo Enabling CacheAwareScheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CacheAwareScheduling" /t REG_DWORD /d "7" /f
echo Possible Values
echo 0, Disabled
echo 1, Enabled, Basic cache-aware Scheduling
echo 2, Enhanced Cache-Aware Scheduling, Best for multi core systems apparently)
echo 7, Full cache-aware scheduling (combination of flags; default on some systems).
echo Default Value : Deleted
echo disabling AeroPeek
reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\ExtendedComposition" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DWM" /v "EnableAeroPeek" /t REG_DWORD /d "0" /f
echo Disabling DWM CPU Clipping
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "EnableCpuClipping" /t REG_DWORD /d "0" /f
echo Disabling DWM Animations
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v ForceDisableModeChangeAnimation /t REG_DWORD /d 1 /f  
taskkill /f /im dwm.exe
timeout /t 2
start %windir%\system32\dwm.exe

md %UserProfile%\Desktop\OptiClub\OOSU10\Cfg

powershell Invoke-WebRequest "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -OutFile "%UserProfile%\Desktop\OptiClub\OOSU10\OOSU10.exe"
timeout /t 3 /nobreak > NUL
powershell Invoke-WebRequest "https://raw.githubusercontent.com/ZaneLS/Configs/refs/heads/main/OptiClub-Safe-Aggressive.cfg" -OutFile "%UserProfile%\Desktop\OptiClub\OOSU10\Cfg\OptiClub-Safe-Aggressive.cfg"
set OOSUPath="%UserProfile%\Desktop\OptiClub\OOSU10\OOSU10.exe"
set ConfigPath="%UserProfile%\Desktop\OptiClub\OOSU10\Cfg\OptiClub-Safe-Aggressive.cfg"

if exist %OOSUPath% (
    if exist %ConfigPath% (
        %OOSUPath% %ConfigPath%
    )
)
start "" /wait "%UserProfile%\Desktop\OptiClub\OOSU10\OOSU10.exe"
echo Done.
timeout /t 5 /nobreak > NUL
powershell Invoke-WebRequest "https://github.com/ZaneLS/MSI_UTIL_V3/raw/refs/heads/main/WPD.exe" -OutFile "%temp%\WPD.exe"
start "" /wait "%temp%\WPD.exe
echo Done.
timeout /t 1 /nobreak > NUL 
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
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvide" /t REG_DWORD /d "1" /f
timeout /t 1 /nobreak > NUL
echo Disabling RPC over Scheduler. (default value = del)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule" /v "DisableRpcOverTcp" /t REG_DWORD /d "00000001" /f
timeout /t 1 /nobreak > NUL
echo Done! Exiting...
pause
color b