$connectTestResult = Test-NetConnection -ComputerName sdestorageaccount.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"sdestorageaccount.file.core.windows.net`" /user:`"localhost\sdestorageaccount`" /pass:`"VDbI7nUAsBY0VcFYBoLsbRWzPxH7HJBMNymK8aAWmUHOocBra1XQLZljtGyGIOr6lAnRiHHCWxvd+ASt9/Ai5w==`""
    # Mount the drive
    net use F: \\sdestorageaccount.file.core.windows.net\sde-share /persistent:yes
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}