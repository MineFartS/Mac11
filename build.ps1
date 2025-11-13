
#=====================================================

# Check and run the script as admin if required
$myWindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal = new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
if (! $myWindowsPrincipal.IsInRole($adminRole)) {
    Write-Output "Restarting mac11 USB Creator as admin in a new window, you can close this one."
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
    exit
}

#=====================================================

# Set the window title
$Host.UI.RawUI.WindowTitle = "Mac11 USB Creator"

Clear-Host

#=====================================================

Write-Host ''
Write-Host 'Mac11 USB Creator'
Write-Host 'Create a Windows 11 Installer USB for Intel Macs'
Write-Host '--------------------------------------------------'


Write-Host ''
Write-Host 'Please enter the drive letter of your mounted tiny11 Image'
$ISO = Read-Host "Drive Letter"


Write-Host ''
Write-Host 'Please enter the drive letter of your USB Flash Drive'
$USB = Read-Host "Drive Letter"

Write-Host ''
Write-Host "The Contents of your Flash Drive will be DESTROYED!"
$confirm = Read-Host "Are you sure you want to proceed? (Y/N)"
if ($confirm -ne 'Y') {
    exit
}

Write-Host ''

#=====================================================

#
$USBdisk = (Get-Partition -DriveLetter $USB | Get-Disk)

Write-Output "Clearing USB Drive ..."
$USBdisk | Clear-Disk `
    -RemoveData `
    -Confirm:$false

Write-Output "Converting to MBR ..."
$USBdisk | Set-Disk `
    -PartitionStyle MBR

Write-Output "Creating Partition ..."
$partition = $USBdisk | New-Partition `
    -UseMaximumSize `
    -DriveLetter $USB `

Write-Output "Formatting Partition ..."
$partition | Format-Volume `
    -FileSystem exFAT `
    -NewFileSystemLabel "Mac11" `
    | Out-Null

#=====================================================

$zipFile = "$env:temp\Win10-BaseSetup.zip"
$extracted = "$env:temp\Win10-BaseSetup\"

# If the extracted folder does not already exist
if (-not (Test-Path $extracted)) {
    
    Write-Output "Downloading Installer Files ..."
    Invoke-WebRequest `
        -Uri "https://media.githubusercontent.com/media/MineFartS/Mac11/refs/heads/main/Win10-BaseSetup.zip" `
        -OutFile $zipFile

    #
    New-Item `
        -ItemType Directory `
        -Path $extracted `
        -ErrorAction SilentlyContinue `
        | Out-Null

    Write-Output "Extracting Installer Files ..."
    Expand-Archive `
        -Path $zipfile `
        -DestinationPath $extracted `
        -Force -Verbose

    #
    Remove-Item `
        -Path $zipFile `
        -Force

}

Write-Output "Copying Installer Files ..."

# Copy Windows 10 Installer Files
Copy-Item `
    -Path $extracted'\*' `
    -Destination $USB':\' `
    -Recurse -Force -Verbose

# Copy Windows 11 Image
Copy-Item `
    -Path $ISO':\sources\install.wim' `
    -Destination $USB':\sources\install.wim' `
    -Force -Verbose

#=====================================================

Write-Output ''
Write-Output "Creation completed!"
Read-Host "Press Enter to exit"