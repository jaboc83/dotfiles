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
	[Switch] $ArtPackages = $false,
	# Install packages typically only associated with gaming
	[Switch] $GamePackages = $false
)

<#
 .SYNOPSIS
Update or install a vim plugin from github
 .DESCRIPTION
This function is uses to pull a vim plugin from github and either
clone it into the bundles directory or update it if it already exists
 .NOTES
Copyright © UnsignedBytes, LLC 2014
#>
Function GetOrUpdateVimBundle
{
	Param
	(
		[Parameter(Mandatory=$True)]
			[String] $GitUser,
		[Parameter(Mandatory=$True)]
			[String] $GitRepo,
		[Parameter()]
			[String] $FolderAlias
	)

	$Github = "https://github.com"
	$user = $env:USERPROFILE
	$bundle = "$user\vimfiles\bundle"
	$FolderName = if ([string]::IsNullOrEmpty($FolderAlias)) { $GitRepo } else { $FolderAlias }

	if(Test-Path "$bundle\$FolderName")
	{
		git -C $bundle\$FolderName pull
	}
	else
	{
		git clone $Github/$GitUser/$GitRepo.git $bundle/$FolderName
	}
}

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

# Default app list for most computers
installOrUpdateChocoPackage "7zip"
installOrUpdateChocoPackage "which"
installOrUpdateChocoPackage "ccleaner"
installOrUpdateChocoPackage "adobereader"
installOrUpdateChocoPackage "dotnet4.5"
installOrUpdateChocoPackage "Firefox"
installOrUpdateChocoPackage "firefox-dev"  "-pre"
installOrUpdateChocoPackage "google-chrome-x64"
installOrUpdateChocoPackage "PowerShell"
installOrUpdateChocoPackage "putty"
installOrUpdateChocoPackage "dropbox"
installOrUpdateChocoPackage "googledrive"
installOrUpdateChocoPackage "vcredist2010"
installOrUpdateChocoPackage "vcredist2012"
installOrUpdateChocoPackage "windirstat"
installOrUpdateChocoPackage "malwarebytes"
installOrUpdateChocoPackage "greenshot"
installOrUpdateChocoPackage "sysinternals"
installOrUpdateChocoPackage "f.lux"
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
if($GamePackages)
{
	InstallOrUpdateChocoPackage "steam"
}

if($DevPackages)
{
	installOrUpdateChocoPackage "ag"
	installOrUpdateChocoPackage "fiddler4"
	installOrUpdateChocoPackage "git"
	installOrUpdateChocoPackage "HaskellPlatform"
	installOrUpdateChocoPackage "erlang"
	installOrUpdateChocoPackage "jdk8"
	installOrUpdateChocoPackage "kdiff3"
	installOrUpdateChocoPackage "mingw"
	installOrUpdateChocoPackage "mongodb.core.2.6"
	installOrUpdateChocoPackage "nodejs"
	npm install jscs -g
	npm install esprima-fb -g
	installOrUpdateChocoPackage "python2"
	installOrUpdateChocoPackage "python2-x86_32"
	installOrUpdateChocoPackage "python3"
	installOrUpdateChocoPackage "ruby"
	installOrUpdateChocoPackage "rust"
	installOrUpdateChocoPackage "tortoisehg"
	installOrUpdateChocoPackage "tortoisesvn"
	installOrUpdateChocoPackage "VS2010.ShellIntegratedRedist"
	#installOrUpdateChocoPackage "visualstudiocommunity2013"
	installOrUpdateChocoPackage "vim"

	# Vim plugin setup
	if(!(Test-Path ~/vimfiles/bundle))
	{
		New-Item ~/vimfiles/bundle -Type Directory -Force
	}

	# install pathogen if it isn't there
	if(!(Test-Path ~/vimfiles/autoload))
	{
		New-Item ~/vimfiles/autoload -Type Directory -Force
		curl --location --show-error --silent --insecure --output $env:USERPROFILE\vimfiles\autoload\pathogen.vim https://tpo.pe/pathogen.vim
	}


	# Move the vimrc into place if it isn't there
	if(!(Test-Path ~/.vimrc))
	{
		Copy-Item .vimrc ~/.vimrc
	}

	# Grab or update the plugins
	GetOrUpdateVimBundle "gmarik" "Vundle.vim"
	GetOrUpdateVimBundle "tfnico" "vim-gradle"
	GetOrUpdateVimBundle "rking" "ag.vim" "ag"
	GetOrUpdateVimBundle "jonathanfilip" "vim-lucius"
	GetOrUpdateVimBundle "othree" "html5.vim"
	GetOrUpdateVimBundle "Shutnik" "jshint2.vim"
	GetOrUpdateVimBundle "scrooloose" "nerdcommenter"
	GetOrUpdateVimBundle "scrooloose" "nerdtree"
	GetOrUpdateVimBundle "wting" "rust.vim"
	GetOrUpdateVimBundle "ervandew" "supertab"
	GetOrUpdateVimBundle "scrooloose" "syntastic"
	GetOrUpdateVimBundle "powerline" "fonts"

	GetOrUpdateVimBundle "bling" "vim-airline"

	# In order to use the powerline fonts in airline you need to change the code page to use UTF-8
	AddToPSProfile "chcp 65001"

	GetOrUpdateVimBundle "hail2u" "vim-css3-syntax"
	GetOrUpdateVimBundle "nathanaelkane" "vim-indent-guides"
	GetOrUpdateVimBundle "pangloss" "vim-javascript"
	GetOrUpdateVimBundle "elzr" "vim-json"
	GetOrUpdateVimBundle "plasticboy" "vim-markdown"
	GetOrUpdateVimBundle "terryma" "vim-multiple-cursors"
	GetOrUpdateVimBundle "tpope" "vim-surround"
	GetOrUpdateVimBundle "PProvost" "vim-ps1"
	GetOrUpdateVimBundle "tpope" "vim-dispatch"
	GetOrUpdateVimBundle "tpope" "vim-fugitive"
	GetOrUpdateVimBundle "mxw" "vim-jsx"
}

# Be sure to upgrade any packages not included in the above list as well
chocolatey upgrade all
