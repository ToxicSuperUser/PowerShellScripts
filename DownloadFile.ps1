$url = "http://example.com/path/to/your/file.txt"
$outputPath = "C:\path\to\save\file.txt"

# Create a new WebClient object
$webClient = New-Object System.Net.WebClient

# Download the file
$webClient.DownloadFile($url, $outputPath)

# Dispose of the WebClient object
$webClient.Dispose()

Write-Host "File downloaded successfully."
