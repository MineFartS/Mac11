
# Check and run the script as admin if required
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
if (! $myWindowsPrincipal.IsInRole($adminRole)) {
    Write-Output "Restarting mac11 image creator as admin in a new window, you can close this one."
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
    exit
}


#---------[ Execution ]---------#

# Set the window title
$Host.UI.RawUI.WindowTitle = "Mac11 Image Creator"

#
Clear-Host

Write-Host 'Mac11'
Write-Host 'Create a Windows 11 Installer USB for Intel Macs'
Write-Host ''

#
$ISO = Read-Host "Image Drive Letter"

#
$USB = Read-Host "USB Drive Letter"

#
$USBdisk = (Get-Partition -DriveLetter $USB | Get-Disk)

Write-Output "Clearing USB Drive ..."
$USBdisk | Clear-Disk `
    -RemoveData `
    -Confirm:$false

Write-Output "Converting USB Drive to MBR ..."
$USBdisk | Set-Disk `
    -PartitionStyle MBR

Write-Output "Creating Partition ..."
$partition = $USBdisk | New-Partition `
    -UseMaximumSize `
    -DriveLetter $USB `

Write-Output "Formatting Partition ..."
$partition | Format-Volume `
    -FileSystem exFAT `
    -NewFileSystemLabel "Mac11"

Write-Output "Copying Windows Files ..."
Copy-Item `
    -Path "$($ISO):\*" `
    -Destination "$($USB):\" `
    -Recurse -Force -Verbose

Write-Output "Downloading BootCamp Files ..."
#Invoke-WebRequest `
#    -Uri "https://raw.githubusercontent.com/minefarts/mac11/refs/heads/main/BootCamp.zip" `
#    -OutFile "$env:temp\BootCamp.zip"

Write-Output "Copying BootCamp Files ..."
Expand-Archive `
    -Path "BootCamp.zip" `
    -DestinationPath "$($USB):\" `
    -Force -Verbose

# 
#Remove-Item `
#    -Path "$env:temp\BootCamp.zip" `
#    -Force

Write-Output "Creation completed!"
Read-Host "Press Enter to exit"