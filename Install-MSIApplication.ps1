<#
.Synopsis
   Short description
    This script will be used for installing silently *msi binary file format.
.DESCRIPTION
   Long description
    2020-11-18 Sukri Created.
    2021-02-06 Sukri Imported some external modules.
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
    Author : Sukri Kadir
    Email  : msmak1990@gmail.com
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>

#import the external functions from the external script files.
. "$PSScriptRoot\Get-AdministrationRight"

#throw exception if no administration right.
$IsAdministrator = Get-AdministrationRight

if ($IsAdministrator -ne $true)
{
    Write-Warning -Message "You are currently running this script WITHOUT the administration right. Please run with administration right. Exit." -WarningAction Stop
}

#function use to install silently *.msi binary file format.
function Install-MSIApplication
{
    Param
    (

    #Parameter for *msi installer file name.
        [ValidateNotNullOrEmpty()]
        [String]
        $BinaryFileName, # e.g.: TortoiseGit-2.11.0.0-32bit.msi

    #Parameter for  *msi installer source directory.
        [ValidateNotNullOrEmpty()]
        [String]
        $InstallerSourceDirectory, # e.g.: C:\Users\<User-Profile>\Downloads

    #Parameter for  *msi installer logging.
        [ValidateNotNullOrEmpty()]
        [String]
        $InstallationLogFile = "$InstallerSourceDirectory\$BinaryFileName`_$( Get-Date -Format "yyyyMMdd_hhmmss" ).log" # e.g.: C:\Users\<User-Profile>\Downloads\TortoiseGit-2.11.0.0-32bit.log
    )

    Begin
    {
        #get full path of *msi binary file.
        $BinaryFile = "$InstallerSourceDirectory\$BinaryFileName"

        #throw exception if *msi installer source directory does not exist.
        if (!$( Test-Path -Path $InstallerSourceDirectory -PathType Container ))
        {
            Write-Error -Message "[$InstallerSourceDirectory] does not exist."  `
                        -RecommendedAction "Check if [$InstallerSourceDirectory] exist or not?." `
                        -Category ObjectNotFound -ErrorAction Stop
        }

        #throw exception if *msi binary file does not exist.
        if (!$( Test-Path -Path $BinaryFile -PathType Leaf ))
        {
            Write-Error -Message "[$InstallerSourceDirectory] does not exist." `
                        -RecommendedAction "check if [$BinaryFile] exist or not?." `
                        -Category ObjectNotFound -ErrorAction Stop
        }

    }
    Process
    {

        <#  Windows ® Installer. V 5.0.19041.1
            msiexec /Option <Required Parameter> [Optional Parameter]
            Install Options
                </package | /i> <Product.msi>
                    Installs or configures a product
                /a <Product.msi>
                    Administrative install - Installs a product on the network
                /j<u|m> <Product.msi> [/t <Transform List>] [/g <Language ID>]
                    Advertises a product - m to all users, u to current user
                </uninstall | /x> <Product.msi | ProductCode>
                    Uninstalls the product
            Display Options
                /quiet
                    Quiet mode, no user interaction
                /passive
                    Unattended mode - progress bar only
                /q[n|b|r|f]
                    Sets user interface level
                    n - No UI
                    b - Basic UI
                    r - Reduced UI
                    f - Full UI (default)
                /help
                    Help information
            Restart Options
                /norestart
                    Do not restart after the installation is complete
                /promptrestart
                    Prompts the user for restart if necessary
                /forcerestart
                    Always restart the computer after installation
            Logging Options
                /l[i|w|e|a|r|u|c|m|o|p|v|x|+|!|*] <LogFile>
                    i - Status messages
                    w - Nonfatal warnings
                    e - All error messages
                    a - Start up of actions
                    r - Action-specific records
                    u - User requests
                    c - Initial UI parameters
                    m - Out-of-memory or fatal exit information
                    o - Out-of-disk-space messages
                    p - Terminal properties
                    v - Verbose output
                    x - Extra debugging information
                    + - Append to existing log file
                    ! - Flush each line to the log
                    * - Log all information, except for v and x options
                /log <LogFile>
                    Equivalent of /l* <LogFile>
            Update Options
                /update <Update1.msp>[;Update2.msp]
                    Applies update(s)
                /uninstall <PatchCodeGuid>[;Update2.msp] /package <Product.msi | ProductCode>
                    Remove update(s) for a product
            Repair Options
                /f[p|e|c|m|s|o|d|a|u|v] <Product.msi | ProductCode>
                    Repairs a product
                    p - only if file is missing
                    o - if file is missing or an older version is installed (default)
                    e - if file is missing or an equal or older version is installed
                    d - if file is missing or a different version is installed
                    c - if file is missing or checksum does not match the calculated value
                    a - forces all files to be reinstalled
                    u - all required user-specific registry entries (default)
                    m - all required computer-specific registry entries (default)
                    s - all existing shortcuts (default)
                    v - runs from source and recaches local package
            Setting Public Properties
                [PROPERTY=PropertyValue]

            Consult the Windows ® Installer SDK for additional documentation on the
            command line syntax.

            Copyright © Microsoft Corporation. All rights reserved.
            Portions of this software are based in part on the work of the Independent JPEG Group.#>

        #install *msi binary file.
        $InstallationProcess = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i", $BinaryFile, "/passive", "/norestart", "/log", $InstallationLogFile -Wait -NoNewWindow -Verbose -ErrorAction Stop

        #throw exception if failed to install *msi binary.
        if ($InstallationProcess.ExitCode -ne 0)
        {
            Write-Warning -Message "[$BinaryFileName] installation failed. Please Check log file from [$InstallationLogFile]."
            Write-Error -Message "[$BinaryFile] failed to install with exit code [$( $InstallationProcess.ExitCode )]." -ErrorAction Stop
        }

    }
    End
    {
        #throw exception if failed to install *msi binary.
        if ($InstallationProcess.ExitCode -eq 0)
        {
            Write-Host "[$BinaryFile] installed successfully. done."
            Write-Host "Check log file from [$InstallationLogFile]"
        }
    }
}

#log the logging into log file.
Start-Transcript -Path "$PSScriptRoot\$( $MyInvocation.ScriptName )"

#execute the function.
Install-MSIApplication

#stop to log the logging.
Stop-Transcript