Write-Host "=============================================="
 Write-Host ""
 Write-Host "          PLEASE SELECT YOUR OPTION          "
 Write-Host ""
 Write-Host "============================================="
 Write-Host ""
 Write-Host " A. End All Disconnected Remote User SESSIONS"
 Write-Host " B. End All Active Remote User SESSIONS"
 Write-Host " C. End All Idle Remote User SESSIONS"
 Write-Host " D. End All Remote User SESSIONS"
 Write-Host " X. Cancel and Quit"
 $choice = Read-Host "Enter Selection"

Switch ($choice) {
 "A" {$RDSessions = Get-RDUserSession | Where-Object -Filter {$_.SessionState -eq 'STATE_DISCONNECTED'} }
 "B" {$RDSessions = Get-RDUserSession | Where-Object -Filter {$_.SessionState -eq 'STATE_ACTIVE'} }
 "C" {$RDSessions = Get-RDUserSession | Where-Object -Filter {$_.SessionState -eq 'STATE_IDLE'} }
 "D" {$RDSessions = Get-RDUserSession}
 "X" {Exit}
 }

If (!$RDSessions)
 {
 Write-Host "No Remote User Sessions found with Choice:" $choice
 }
 Else
 { # Start Loop
 Foreach ($RDSession in $RDSessions)
 {
 Invoke-RDUserLogoff -UnifiedSessionID $RDSession.SessionId -HostServer $RDSession.HostServer -Force
 Write-Host "The User" $RDSession.UserName "is logged off from" $RDSession.HostServer "server"
 } # End Loop
 } # End If
 
Read-Host {"Press Enter to Exit <---"}
