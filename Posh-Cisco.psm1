# Import PowerShell SSH Module
Import-Module Posh-SSH;

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Get-CiscoSSHResponse
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey,
		[Parameter(Mandatory=$true)]
		[String]$Command,
		[Parameter(Mandatory=$false)]
		[String]$StripHeaderAt = $null
    )

    $SSHSession = New-SSHSession -ComputerName $HostAddress -Port $HostPort -Credential $Credential -AcceptKey:$AcceptKey;
        
    if ($SSHSession.Connected)
    {
        $SSHResponse = Invoke-SSHCommand -SSHSession $SSHSession -Command $Command;
    
        Remove-SSHSession -SSHSession $SSHSession | Out-Null;

        $Result = $SSHResponse.Output | Out-String;

        $StartIndex = 0;

        if ($StripHeaderAt)
        {
            $StartIndex = $Result.IndexOf("`n$StripHeaderAt") + 1;
        }

        return $Result.Substring($StartIndex).Trim();
    }
    else
    {
        throw [System.InvalidOperationException]"Could not connect to SSH host: $($HostAddress):$HostPort.";
    }
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Get-CiscoStartupConfig
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )

    return (Get-CiscoSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'show startup-config' -StripHeaderAt '!');
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Backup-CiscoStartupConfig
{
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey,
		[Parameter(Mandatory=$true)]
		[String]$FilePath
    )

    Get-CiscoStartupConfig -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey | Out-File -FilePath $FilePath;
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Get-CiscoRunningConfig
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )

    return (Get-CiscoSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'show running-config' -StripHeaderAt '!');
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Backup-CiscoRunningConfig
{
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey,
		[Parameter(Mandatory=$true)]
		[String]$FilePath
    )

    Get-CiscoRunningConfig -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey | Out-File -FilePath $FilePath;
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Get-CiscoInterfacesStatus
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )
    
    return (Get-CiscoSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'show interfaces status' -StripHeaderAt 'Port  ');
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Get-CiscoLogging
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )

    return (Get-CiscoSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'show logging' -StripHeaderAt 'Syslog ');
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Get-CiscoLoggingOnboard
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )

    return (Get-CiscoSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'show logging onboard' -StripHeaderAt 'PID: ');
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Get-CiscoVersion
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )

    return (Get-CiscoSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'show version' -StripHeaderAt 'Cisco IOS Software, ');
}

# .ExternalHelp Posh-Cisco.psm1-Help.xml
function Get-CiscoVlan
{
    [OutputType([String])]
    param
    (
		[Parameter(Mandatory=$true)]
		[String]$HostAddress,
		[Parameter(Mandatory=$false)]
		[Int]$HostPort = 22,
		[Parameter(Mandatory=$true)]
		[PSCredential]$Credential,
		[Parameter(Mandatory=$false)]
		[Switch]$AcceptKey
    )

    return (Get-CiscoSSHResponse -HostAddress $HostAddress -HostPort $HostPort -Credential $Credential -AcceptKey:$AcceptKey -Command 'show vlan' -StripHeaderAt 'VLAN ');
}
