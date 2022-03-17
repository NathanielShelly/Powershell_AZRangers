
$ComputerNames = 'LON-DC1, LON-SVR1'

Function Get-WindowsUpdateLog {
    [cmdletbinding()]
    Param(
    [Parameter(Position=0,ValueFromPipeline)]
    [ValidateNotNullorEmpty()]
    [string[]]$Computername = $env:COMPUTERNAME
    )
    Begin {
        Write-Verbose "Starting $($MyInvocation.Mycommand)"
        $header = "Date","Time","PID","TID","Component","Message"
    } 
    Process {
        Write-Verbose "Processing Windows Update Log on $($($computername.toUpper()) -join ",")"
        
        $sb = {
        Import-Csv -Delimiter `t -Header $using:header -Path C:\windows\WindowsUpdate.log |
        Select-Object @{Name="DateTime";Expression={
        "$($_.date) $($_.time.Substring(0,8))" -as [datetime]}},
        @{Name="PID";Expression={$_.PID -as [int]}},
        @{Name="TID";Expression={$_.TID -as [int]}},Component,Message
        }
        Try {
           Invoke-Command -ScriptBlock $sb -ComputerName $Computername -errorAction Stop |
           Select-Object * -ExcludeProperty RunspaceID
        }
        Catch {
            Throw $_
        }
    } 
    End {
        Write-Verbose "Ending $($MyInvocation.Mycommand)"
    } 
    } 

    $data = Get-WindowsUpdateLog -Computername $ComputerNames -verbose
     $data.where({$_.DateTime -ge "3/17/2022" -AND $_.Message -match "Fatal"})| Sort-Object DateTime,PSComputername | 
    Select-Object PSComputername,DateTime,Component,Message |
    format-table –AutoSize | export-csv .\LogErrors.csv -Append
