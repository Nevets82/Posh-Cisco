# Posh-Cisco PowerShell Cisco Module

This PowerShell module provides some functionality to facilitate automating backup actions of a Cisco device over SSH. This PowerShell module also provides some basic functionality for troubleshooting Cisco devices.

## Dependencies

This module depends on the following PowerShell modules:

* [Posh-SSH (PowerShell SSH Module)](https://www.powershellgallery.com/packages/Posh-SSH "Posh-SSH PowerShell SSH Module") 

## Inspect

```PowerShell
PS> Save-Module -Name Posh-Cisco -Path <path>
```

## Install

```PowerShell
PS> Install-Module -Name Posh-Cisco
```

## Functionality

* Backup-CiscoRunningConfig: Gets the running configuration and writes it to a file. (only allowed on privilege level 15)
* Backup-CiscoStartupConfig: Gets the startup configuration and writes it to a file.
* Get-CiscoInterfacesStatus: Gets the interfaces status.
* Get-CiscoLogging: Gets the logging information.
* Get-CiscoLoggingOnboard: Gets the onboard logging information.
* Get-CiscoRunningConfig: Gets the running configuration. (only allowed on privilege level 15)
* Get-CiscoStartupConfig: Gets the startup configuration.
* Get-CiscoVersion: Gets the version information.
* Get-CiscoVlan: Gets the vlan information.

## Usage

### Backup Running Configuration

This PowerShell command gets the running configuration and writes it to a file. (only allowed on privilege level 15)

```PowerShell
PS> Backup-CiscoRunningConfig -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey -FilePath "$([Environment]::GetFolderPath(“MyDocuments”))\running-config.txt"
```

### Backup Startup Configuration

This PowerShell command gets the startup configuration and writes it to a file.
```PowerShell
PS> Backup-CiscoStartupConfig -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey -FilePath "$([Environment]::GetFolderPath(“MyDocuments”))\startup-config.txt"
```

### Show Interfaces Status

This PowerShell command gets the interfaces status.
```PowerShell
PS> Get-CiscoInterfacesStatus -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey
```

### Show Logging Information

This PowerShell command gets the logging information.
```PowerShell
PS> Get-CiscoLogging -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey
```

### Show Onboard Logging Information

This PowerShell command gets the onboard logging information. 
```PowerShell
PS> Get-CiscoLoggingOnboard -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey
```

### Show Running Configuration

This PowerShell command gets the running configuration. (only allowed on privilege level 15)
```PowerShell
PS> Get-CiscoRunningConfig -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey
```

### Show Startup Configuration

This PowerShell command gets the startup configuration.
```PowerShell
PS> Get-CiscoStartupConfig -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey
```

### Show Version Information

This PowerShell command gets the version information.
```PowerShell
PS> Get-CiscoVersion -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey
```

### Show VLAN Information

This PowerShell command gets the VLAN information.
```PowerShell
PS> Get-CiscoVlan -HostAddress "192.168.0.1" -HostPort 22 -Credential (Get-Credential) -AcceptKey
```

## Security Considerations

Before you create scripts that use this module, you should create a readonly user with the necessary rights to be used for the PSCredentials.

```
configure terminal
user readonly privilege 3 password 0 enterastrongpasswordhere
privilege exec level 3 show startup-config
privilege exec level 3 show logging onboard
```
Remark: A readonly user will not be able to read the running-config, this requires privilege level 15.

## Compatibility

These PowerShell functions were tested on the following Cisco devices:

* WS-C2960X-24TS-L (SW version: 15.2(3)E)
* WS-C2960X-24TS-L (SW version: 15.2(5)E)
* WS-C2960X-48TS-L (SW version: 15.2(3)E)
* WS-C2960X-48TS-L (SW version: 15.2(5)E)
* WS-C3850-24S (SW version: 03.06.05E)

## Change Log

### Version 1.0.1

#### New Features

* Added -AcceptKey switch to all functions to automatically accept SSH Key

### Version 1.0.0

#### New Features

* Added documentation
* Added support to get logging information (Get-CiscoLogging)
* Added support to get onboard logging information (Get-CiscoLoggingOnboard)
* Added support to get vlan information (Get-CiscoVlan)

#### Bug Fixes

* Fixed bug in Get-CiscoRunningConfig (first character was missing)
* Fixed bug in Get-CiscoStartupConfig (first character was missing)

### Version 0.0.0.1

#### New Features

* Added support to backup running-config to a file (Backup-CiscoRunningConfig)
* Added support to backup startup-config to a file (Backup-CiscoStartupConfig)
* Added support to get running-config (Get-CiscoRunningConfig)
* Added support to get startup-config (Get-CiscoStartupConfig)
* Added support to get interfaces status (Get-CiscoInterfacesStatus)
* Added support to get version information (Get-CiscoVersion)

## Todo

* Test on more devices
* Backup vlan.dat
* ...
