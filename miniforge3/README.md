# <img src="https://rawcdn.githack.com/geicht/chocolatey-packages/b2ddc74a806f3b2d24eb40197f9a511dae49a43f/miniforge3/img/miniforge.png" width="48" height="48"/> [miniforge3](https://community.chocolatey.org/packages/miniforge3)[![](http://transparent-favicon.info/favicon.ico)](#)[![Latest version](https://repology.org/badge/version-for-repo/chocolatey/miniforge3.svg?header=Latest%20version)](https://community.chocolatey.org/packages/miniforge3/24.9.2.000)

Miniforge3 installs the conda package manager with the following features pre-configured:

  * [conda-forge](https://conda-forge.org/) set as the default (and only) channel.
  * Packages in the base environment are obtained from the [conda-forge channel](https://anaconda.org/conda-forge).

You can provide parameters for the installation ([conda docs](https://conda.io/projects/conda/en/latest/user-guide/install/windows.html#installing-in-silent-mode)).  
To have choco remember parameters on upgrade, be sure to set `choco feature enable -n=useRememberedArgumentsForUpgrades`.

  * `/InstallationType:`[`AllUsers`|`JustMe`]
    * Default: `AllUsers` (install for all users)
  * `/RegisterPython:`[`0`|`1`]
    * Default: `1` (register miniforge3 python as the system's default)
  * `/AddToPath:`[`0`|`1`]
    * Default: `0` (do not add miniforge3 directories to path)
    * _Note: As of Miniforge3 4.12.0-0, you cannot add miniforge3 to the PATH environment during an `AllUsers` installation.  
      This was done to address [a security exploit](https://nvd.nist.gov/vuln/detail/CVE-2022-26526) 
      ([additional information](https://github.com/ContinuumIO/anaconda-issues/issues/12995#issuecomment-1188441961))._
  * `/D:`(installation path)
    * Default for `AllUsers`: `$toolsDir\miniforge3`  
      (`$toolsDir` is the path returned by chocolatey's `Get-ToolsLocation` function and defaults to `C:\tools`)
    * Default for `JustMe`: `$Env:LOCALAPPDATA\miniforge3`  
      (`$Env:LOCALAPPDATA` is set by Windows and defaults to `C:\Users\{USERNAME}\AppData\Local`)

Example: `choco install miniforge3 --params="'/InstallationType:JustMe /AddToPath:1'"`.
