# auto-install-msi-binary-file
* 2020-11-18 Sukri Created.
* 2020-11-18 Sukri Added on what script does.
* 2020-11-18 Sukri Added on how to run the script.

---

### Description:
> * PowerShell script to install silently all *.msi binary file format (Windows 10 + PS ver5.1.x).

---

### Below are steps on what script does:

1. Validate on three required parameters which are *msi binary file name, *msi binary directory path, installation log file directory.
2. Check if script run with administration right. If not then exit current process.
3. Validate if full path of *msi binary file exists or not. if not, then throw exception error message.
4. Install silently *msi binary file and throw exception if getting error during installation process.
5. Log installation file into the same location directory with *msi binary file.  
---  

### How to run this script.

1. Go to the cloned directory which contain both Install-MSIAppplication.cmd and Install-MSIApplication.ps1 files.
2. Customize parameters for *msi binary file name and its directory from Install-MSIApplication.PS1
2. Right-click on Install-MSIApplication.cmd file and run as administrator.

Note: both of files need to locate the same directory or folder.

---

### Function involved:

1. Install-MSIApplication

> * This function used for installing silently all the *msi binary file format.