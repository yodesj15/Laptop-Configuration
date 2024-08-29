# YOAN DESJARDINS

# TO DO: BEFORE LAUNCHING SCRIPT
# 1- Launch Powershell admin
# 2- Set-ExecutionPolicy Unrestricted 
# 3- cd D: 
# 4- cd '.\SCRIPTS\'

# All softwares are located in SOFTWARES folder
Set-Location "$pwd\SOFTWARES"
$directoryPath = Get-Location

# All software installer file path should be here
$inAgentInstaller = "432WindowsAgentSetup_VALID_UNTIL_2025_02_25.exe"
$fortiVPN = "FortiClientVPNSetup.exe"
$teams = "TeamsSetup_c_w_.exe"
$antiVirus = "CHECKPOINT EDR AND VPN\EPS_2024-06-02T23 50 27.479_V88.00.0187.exe"
$adobeReader = "AdobeReaderInstaller.exe"
$office = "OFFICE365\OfficeSetup.exe"
$project = "OFFICE365\Project.exe"
$nitro = "NITRO PRO\NITRO PRO 14\nitro_pro14_x64.msi"
$chrome = ".\chrome_install.ps1"

# List of all software installer that will make a copu of the installer on the Desktop
# This can resolve some issues with the installer
$global:copyToDeskExeList = @($adobeReader, $office, $antiVirus, $fortiVPN)


# Function used to install executable. 3 options are available : silent installation,
# wait the installer to be done and an option to copy the installer on the desktop (Can resolve some issues).  
function Install-exe {
    param (
        [string]$exePath,
        [string]$exeName,
        [bool]$silentInstall,
        [bool]$wait = $true,
        [bool]$copyToDesk = $false
    )
    Clear-Host
    $exe = $exePath
    $executablePath = Join-Path -Path $directoryPath -ChildPath $exe

    if (Test-Path $executablePath) {
        Write-Host "Downloading $exeName ..." 
        if ($silentInstall) {
            $Arguments = @(
                "/S"
                "/V/qn"
            )
            Start-Process -FilePath $executablePath -ArgumentList $Arguments -Wait -NoNewWindow
        }
        elseif (!$wait) {
            Start-Process -FilePath $executablePath 
        }
        elseif ($copyToDesk) {
            $desktopPath = [Environment]::GetFolderPath("Desktop")
            $desktopCopyPath = Join-Path -Path $desktopPath -ChildPath $exe

            Write-Host "Copying $exe to Desktop ..."
            Copy-Item -Path $executablePath -Destination $desktopCopyPath
            Write-Host "Launching $exe from Desktop ..."
            Start-Process -FilePath $desktopCopyPath -Wait

           	# Check if the exe is not already deleted
            if (Test-Path -Path $desktopCopyPath) {
                Write-Host "Removing $exe from Desktop ..."
                Remove-Item -Path $desktopCopyPath -Force		
            }
        }
        else {
            # Normal installation with option wait
            Start-Process -FilePath $executablePath -Wait
        }
        Write-Host "$exeName is done" -ForegroundColor Green -BackgroundColor Black

    }
    else {
        Write-Host "-- Failed to install. The folder $exe does not exist --" -ForegroundColor White -BackgroundColor Red
    }
}

# Function used to install multiple exe 3 at a time. Only a list of all the exe are needed. 
function Multi-Exe-Install {
    param (
        [string[]]$exeList
    )
    $executables = $exeList
    $exeCount = $executables.Length

    $processRunning = 0
    $maxProcessRunning = 3

    foreach ($exe in $executables) {      
        if ($exe -eq $chrome) {
            Invoke-Expression -Command $chrome
        }
        elseif ($global:copyToDeskExeList -contains $exe) {
            Install-exe -exePath $exe -exeName $exe -silentInstall $false -copyToDesk $true -wait $false
        }
        else {
            Install-exe -exePath $exe -exeName $exe -silentInstall $false -wait $false
        }
        $processRunning++
        if (($processRunning % $maxProcessRunning -eq 0) -and ($processRunning -lt $exeCount) ) {
            Write-Host "Waiting ..."
            Start-Sleep -Seconds 10
            Read-host "Press ENTER when all installations are complete..."
        }
    }

}

# Main program
do {
    # Display the main Menu
    Write-Host ""
    Write-Host "-----------------------------------------------------------"
    Write-Host "Press the following numbers to choose an option:" -ForegroundColor Black -BackgroundColor White
    Write-Host "-----------------------------------------------------------"
    Write-Host "1-   Install Teams"
    Write-Host "2-   Install FortiClient"
    Write-Host "3-   Install EDR Anti-Virus"
    Write-Host "4-   Install N-Agent"
    Write-Host "5-   Install Adobe Reader"
    Write-Host "6-   Install Office"
    Write-Host "7-   Install Nitro"
    Write-Host "8-   Install Chrome"
    Write-Host "9-  Install Microsoft Project"
    Write-Host "A-   Install only necessary softwares"
    Write-Host ""
    Write-Host "C-   Enter Custom Installation Mode" -ForegroundColor Black -BackgroundColor Green

    Write-Host "U-   Install Windows Updates" -ForegroundColor Black -BackgroundColor Cyan
    Write-Host "R-   Restart computer"-ForegroundColor Black -BackgroundColor Yellow
    Write-Host "X-   Quit" -ForegroundColor White -BackgroundColor Red
    Write-Host "-----------------------------------------------------------"
    Write-Host ""

    # Ask the user to enter an option
    $choice = Read-Host "Enter the option number "

    # Process the user's choice
    switch ($choice) {
        1 {
            Install-exe -exePath $teams -exeName "Teams" -silentInstall $true
        }
        2 {
            Install-exe -exePath $fortiVPN -exeName "FortiClient" -silentInstall $false -copyToDesk $true
        }
        3 {
            Install-exe -exePath $antiVirus -exeName "EDR" -silentInstall $false -copyToDesk $true
        }
        4 {
            Install-exe -exePath $inAgentInstaller -exeName "N-Agent" -silentInstall $false
        }
        5 {
            Install-exe -exePath $adobeReader -exeName "Adobe Reader" -silentInstall $true -copyToDesk $true
        }
        6 {
            Install-exe -exePath $office -exeName "Office365" -silentInstall $false
        }
        7 {
            Install-exe -exePath $nitro -exeName "Nitro" -silentInstall $false
        }
        8 {
            Invoke-Expression -Command $chrome
        }
        9 {
            Install-exe -exePath $project -exeName "Microsoft Project" -silentInstall $false
        }
        "A" {
            Multi-Exe-Install -exeList @($adobeReader, $chrome, $inAgentInstaller, $antiVirus, $office, $teams)
        }
        "C" {
            # This option can be edited to automate software installation depending of the person title 
            Clear-Host
            Write-Host "Custom mode selected"
            # Display the custom mode menu
            Write-Host ""
            Write-Host "-----------------------------------------------------------"
            Write-Host "Press the following numbers to choose an option:" -ForegroundColor Black -BackgroundColor Green
            Write-Host "-----------------------------------------------------------"
            Write-Host "1-   Configuration for : Charge de projets"
            Write-Host "2-   Configuration for : Employe avec installation de base (Avec VPN & Sans Nitro PDF)"
            Write-Host "3-   Configuration for : Employe avec installation de base (Sans VPN & Sans Nitro PDF)"
            Write-Host "4-   Configuration for : Employe avec installation de base (Avec VPN & Nitro PDF)"
            Write-Host "5-   Configuration for : Employe avec installation de base (Sans VPN & Avec Nitro PDF)"

            Write-Host "X-   Exit Custom Menu" -ForegroundColor White -BackgroundColor Red
            Write-Host "-----------------------------------------------------------"
            Write-Host ""
            $typeInstallation = Read-Host "Choose which type of configuration you would like "
            switch ($typeInstallation) {
                1 {
                    Multi-Exe-Install -exeList @($adobeReader, $chrome, $inAgentInstaller, $antiVirus, $office, $teams, $project, $nitro, $fortiVPN, $maestro1)
                }
                2 {
                    Multi-Exe-Install -exeList @($adobeReader, $chrome, $inAgentInstaller, $antiVirus, $office, $teams, $fortiVPN)
                }
                3 {
                    Multi-Exe-Install -exeList @($adobeReader, $chrome, $inAgentInstaller, $antiVirus, $office, $teams)
                }
                4 {
                    Multi-Exe-Install -exeList @($adobeReader, $chrome, $inAgentInstaller, $antiVirus, $office, $teams, $nitro, $fortiVPN)
                }
                5 {
                    Multi-Exe-Install -exeList @($adobeReader, $chrome, $inAgentInstaller, $antiVirus, $office, $teams, $nitro)
                }
                "X" {
                    # Exit the custom menu
                    Clear-Host
                    Write-Host "Exiting Custom Mode..."
                    break 
                }
                default {
                    Clear-Host
                    Write-Warning "Invalid choice"
                }
            }
            
        }
        "U" {
            # Install all Windows update

            Write-Host "Getting Windows Updates Module" 
            Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck
            Import-Module PSWindowsUpdate

            Write-Host "Getting Updates" 
            Get-WindowsUpdate

            Write-Host "Installing Updates" 
            Install-WindowsUpdate -AcceptAll -IgnoreReboot

            Uninstall-Module -Name PSWindowsUpdate -Force
        }
        "R" {
            Clear-Host
            $userChoice = Read-host "Confirm Restart Y/N"
            if ($userChoice.ToLower() -eq "y" ) {
                Write-Host "Restarting computer " 
                Set-Location ..
                Restart-Computer
                break 
            }
            else {
                Write-Host "Restart Canceled " -ForegroundColor White -BackgroundColor Red
            }
            
        }
        "X" {
            Clear-Host
            Write-Host "Exit..."
            # Returning to the main branch file
            Set-Location ..
            break 
        }
        default {
            Clear-Host
            Write-Warning "Invalid choice"
        }
    }
}while ($choice -ne "x")
