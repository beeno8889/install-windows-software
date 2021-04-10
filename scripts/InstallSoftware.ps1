# Need to run Set-ExecutionPolicy Unrestricted
param ($sourceURL='https://commondatastorage.googleapis.com/chromium-browser-snapshots/Win_x64/871178/chrome-win.zip', $destinationFolder='C:\Program Files')

$Logfile="C:\temp\install-$(get-date -f MM-dd-yyyy_HH_mm_ss).log"
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

try {
$tempFilePath='C:\temp\temp.zip'
$downloadFolder='C:\temp\downloadfolder'

$webClient = New-Object -TypeName System.Net.WebClient
$webClient.DownloadFile($sourceURL, $tempFilePath)
Expand-Archive -Path $tempFilePath -DestinationPath $downloadFolder
ls $downloadFolder
mv $downloadFolder\* $destinationFolder

# Clean up
rm $tempFilePath
rmdir $downloadFolder
} catch {
Write-Host "An error occurred, check the log file $Logfile"
LogWrite "ERROR: $_"
}