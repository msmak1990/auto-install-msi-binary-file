# auto-install-msi-binary-file
Date | Modified by | Remarks
:----: | :----: | :----
2020-11-18 | Sukri | Created.
2020-11-18 | Sukri | Added on what script does.
2020-11-18 | Sukri | Added on how to run the script.
2020-11-18 | Sukri | Added its function descriptions.
2021-02-06 | Sukri | Imported the external modules into the main script.

---

## Description:
> * This is the PowerShell script to install **silently** all `*.msi` binary file format.
> * All done by automated way!.

Windows Version | OS Architecture | PowerShell Version | Result
:----: | :----: | :----: | :----
Windows 10 | 64-bit and 32-bit | 5.1.x | Tested. `OK`

---

### Below are steps on what script does:

No. | Steps
:----: | :----
1 | Pre-validate to check the administration right when executing the script.
2 | Pre-validate on three **required** parameters which are `*.msi` binary file name, `*.msi` binary directory, installation _log file_ directory.
3 | Validate the availability of full path of `*msi` binary file exists or not. If not, then throw the exception error message.
4 | Install silently `*msi` binary file 
5 | Throw an error exception handling message if getting an error during the installation process.
6 | Write the installation process into the file from the base location directory of `*msi` binary file.  
---  

### How to run this script.

Step # | Action
:----: | :---
1 | Go to the cloned directory which contains both `Install-MSIAppplication.cmd` and `Install-MSIApplication.ps1` files.
2 | Customize some parameters for `*msi` binary file name and its directory from `Install-MSIApplication.ps1`.
2 | Right-click on `Install-MSIApplication.cmd` file and run it as administrator.

**_Note: both of files need to locate the same directory or folder._**

---

### Functions involved:

No. | Function Name | Description
:----: | :----: | :----
1 | `Install-MSIApplication` | This function is used to install **silently** all the `*msi` binary file format.