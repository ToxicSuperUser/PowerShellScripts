$port = 80
$computer = "192.168.1.15"

$ping = Test-Connection -ComputerName $computer -Count 1 -Quiet

if ($ping) {
    $open = New-Object Net.Sockets.TcpClient

    try {
        $open.BeginConnect($computer, $port, $null, $null)
        $open.EndConnect($open.BeginConnect($computer, $port, $null, $null))
        Write-Host "Port $port is open on $computer" -ForegroundColor Green
    } catch {
        Write-Host "Port $port is closed on $computer" -ForegroundColor Red
    } finally {
        $open.Close()
    }
} else {
    Write-Host "$computer is not reachable" -ForegroundColor Red
}