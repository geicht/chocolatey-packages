# <img src="https://rawcdn.githack.com/geicht/chocolatey-packages/f015cfa194ac304abed804777d062f28c5db5e77/mambaforge/img/mambaforge.png" width="48" height="48"/> [mambaforge](https://community.chocolatey.org/packages/mambaforge)[![](http://transparent-favicon.info/favicon.ico)](#)[![Latest version](https://repology.org/badge/version-for-repo/chocolatey/mambaforge.svg?header=Latest%20version)](https://community.chocolatey.org/packages/mambaforge/4.13.0.100)

Mambaforge installs the mamba package manager with the following features pre-configured:

  * [conda-forge](https://conda-forge.org/) set as the default (and only) channel.
  * Packages in the base environment are obtained from the [conda-forge channel](https://anaconda.org/conda-forge).

You can provide parameters for the install ([conda docs](https://conda.io/projects/conda/en/latest/user-guide/install/windows.html#installing-in-silent-mode)). Example: `choco install mambaforge --params="'/AddToPath:1'"`.  
To have choco remember parameters on upgrade, be sure to set `choco feature enable -n=useRememberedArgumentsForUpgrades`.

  * /InstallationType:[AllUsers|JustMe]
    * Default: AllUsers (install for all users)
  * /RegisterPython:[0|1]
    * Default: 1 (register mambaforge python as the system's default)
  * /AddToPath:[0|1]
    * Default: 0 (do not add mambaforge directories to path)
  * /D:(installation path)
    * Default-AllUsers: `$toolsDir\mambaforge` (`$toolsDir` is the path returned by `Get-ToolsLocation`) default is `C:\tools`
    * Default-JustMe: `$Env:LOCALAPPDATA\mambaforge` (`$Env:LOCALAPPDATA` is set by Windows) default is `C:\Users\{USERNAME}\AppData\Local`
