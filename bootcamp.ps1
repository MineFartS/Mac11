
#=====================================================

# Set the window title
$Host.UI.RawUI.WindowTitle = "Mac11 USB Creator"

Clear-Host

#=====================================================

Write-Host ''
Write-Host 'Mac11 USB Creator'
Write-Host 'Create a Windows 11 Installer USB for Intel Macs'
Write-Host '--------------------------------------------------'

#=====================================================

Write-Output 'Please enter the model number of the computer used'
Write-Output "Ex: MacBookAir9,1"
$Model = Read-Host 'Model'

#=====================================================

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
$partition = Get-Partition -DriveLetter $USB

Write-Output "Formatting Partition ..."
$partition | Format-Volume `
    -FileSystem exFAT `
    -NewFileSystemLabel "Mac11" `
    | Out-Null

#=====================================================

$brigadier = "$env:temp\brigadier.exe"
$drivers = "$env:temp\brigadier-BootCamp\"

# If the extracted folder does not already exist
if (-not (Test-Path $brigadier)) {
    
    Write-Output "Downloading Brigadier ..."
    Invoke-WebRequest `
        -Uri "https://github.com/timsutton/brigadier/releases/download/0.2.6/brigadier.exe" `
        -OutFile $brigadier

}

if (Test-Path $drivers) {
    Remove-Item `
        -Path $drivers `
        -Recurse -Force
}

New-item `
    -ItemType Directory `
    -Path $drivers

& $brigadier `
    --model $Model `
    --output-dir $drivers

$extracted = (Get-ChildItem `
    -Path $drivers `
    -Directory `
    | Select-Object -First 1 `
).FullName

# Copy Windows 10 Installer Files
Copy-Item `
    -Path $extracted'\*' `
    -Destination $USB':\' `
    -Recurse -Force -Verbose

#=====================================================

Write-Output ''
Write-Output "Creation completed!"
Read-Host "Press Enter to exit"