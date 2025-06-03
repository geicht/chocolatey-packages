FROM chocolatey/choco:latest

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]

RUN \
  # Update the list of packages
  apt-get update && \
  # Install pre-requisite packages.
  apt-get install -y wget apt-transport-https software-properties-common && \
  # Get the version of Debian
  source /etc/os-release && \
  # Download the Microsoft repository GPG keys
  wget -q https://packages.microsoft.com/config/debian/$VERSION_ID/packages-microsoft-prod.deb && \
  # Register the Microsoft repository GPG keys
  dpkg -i packages-microsoft-prod.deb && \
  # Delete the Microsoft repository GPG keys file
  rm packages-microsoft-prod.deb && \
  # Update the list of packages after we added packages.microsoft.com
  apt-get update && \
  # Install PowerShell
  apt-get install -y powershell

# Allow every user to access chocolatey files
RUN chmod -R 777 /opt/chocolatey/

# Set the default shell to pwsh
SHELL ["/usr/bin/pwsh", "-Command"]

# Install needed powershell modules
RUN \
  Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted; \
  Install-Module -Name au -Force -Scope AllUsers; \
  Install-Module -Name wormies-au-helpers -Force -Scope AllUsers;

# Create and use user "choco"
RUN useradd -m -U choco
USER choco

# Create volume mount
VOLUME /packages

# Change working directory
WORKDIR /packages

# Start PowerShell
CMD [ "pwsh" ]
