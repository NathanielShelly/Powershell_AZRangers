$computername = "TestComputer"

Get-NetIPAddress -CimSession $computername -AddressFamily IPv4 |
    Where-Object { $_.InterfaceAlias -notmatch 'Loopback'} |
    Select-Object PSComputername,IPAddress, @{Name = "MACAddress";Expression={
        ($_ | Get-NetAdapter).MACAddress.Replace("-",":")
    }
}
