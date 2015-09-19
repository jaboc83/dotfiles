<# ------------------------------------------------------------------
  This script is used to install and update
  Chocolatey packages and Vim bundles for
  my local windows machine setup.

  Be sure to install the powerline fonts with the script below
  and set your Conemu font to Inconsolata for Powerline in order
  to use the fancy vim-airline stuff.

		$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
		Get-ChildItem ~/vimfiles/bundle/powerline-fonts/**/*.ttf | %{ $fonts.CopyHere($_.fullname) }

  Copyright © UnsignedBytes, LLC 2014
-------------------------------------------------------------------#>

Param
(
	# Install packages typically only associated with development
	[Switch] $DevPackages = $false,
	# Use the pre-release version of chocolatey (for beta testing)
	[Switch] $UseNewChocolatey = $false,
	# Install packages typically only associated with art/photography
	[Switch] $ArtPackages = $false
)

<#
 .SYNOPSIS
Update or install a chocolatey package
 .DESCRIPTION
This function is uses to pull a chocolatey package and either
install it or update it if it already exists
 .NOTES
Copyright © UnsignedBytes, LLC 2014
#>
Function InstallOrUpdateChocoPackage
{
	Param
	(
		[Parameter(Mandatory=$True)]
			[String] $packageName,
		[Parameter(Mandatory=$False)]
			[String] $chocoArgs
	)

	if((chocolatey list -lo | Select-String $packageName) -eq $NULL)
	{
		chocolatey install $packageName $chocoArgs -y
	}
	else
	{
		chocolatey upgrade $packageName $chocoArgs -y
	}

}

<#
 .SYNOPSIS
Add content to your user profile for powershell
 .DESCRIPTION
This function will append the content provided to the end of
the user's powershell profile in the ~/Documents/WindowsPowerShell dir.
 .NOTES
Copyright © UnsignedBytes, LLC 2014
#>
Function AddToPSProfile
{
	Param
	(
		[Parameter(Mandatory=$True)]
			[String] $Content
	)

	# Only update the profile if it doesn't have the content
	if((Get-Content $PROFILE | Select-String $Content) -eq $Null)
	{
		# Create the profile if it doesn't exist
		if(!(Test-Path ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1))
		{
			New-Item ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 -Type File -Force
		}
		Add-Content $PROFILE $Content
	}
}

# Verify Chocolatey is installed
try
{
	chocolatey
}
catch
{
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Update chocolatey first
if($UseNewChocolatey)
{
	chocolatey upgrade Chocolatey -Pre -y
}
else
{
	chocolatey upgrade Chocolatey -y
}

# Install PSGet
if ((get-module | where { $_.Name -eq 'PsGet' }).Count -ne 1) {
	(new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

# Default app list for most computers
installOrUpdateChocoPackage "7zip"
installOrUpdateChocoPackage "adobereader"
installOrUpdateChocoPackage "Firefox"
installOrUpdateChocoPackage "firefox-dev"  "-pre"
installOrUpdateChocoPackage "google-chrome-x64"
installOrUpdateChocoPackage "putty"
installOrUpdateChocoPackage "dropbox"
installOrUpdateChocoPackage "windirstat"
installOrUpdateChocoPackage "greenshot"
installOrUpdateChocoPackage "curl"

# Remove the Powershell curl alias to use the curl package
if((Get-Alias | Select-String curl) -ne $Null) {
	Remove-Item alias:curl
}
# Remove the curl alias on PS startup for future sessions
AddToPSProfile "Remove-Item alias:curl"

if($ArtPackages)
{
	InstallOrUpdateChocoPackage "inkscape"
	InstallOrUpdateChocoPackage "paint.net"
}

if($DevPackages)
{
	installOrUpdateChocoPackage "ag"
	installOrUpdateChocoPackage "fiddler4"
	installOrUpdateChocoPackage "git"
	installOrUpdateChocoPackage "jdk8"
	installOrUpdateChocoPackage "kdiff3"
	installOrUpdateChocoPackage "mingw"
	installOrUpdateChocoPackage "nodejs"
	npm install jscs -g
	installOrUpdateChocoPackage "python2"
	installOrUpdateChocoPackage "python2-x86_32"
	installOrUpdateChocoPackage "python3"

	# PSGet Modules
	#Install-Module posh-git
}
