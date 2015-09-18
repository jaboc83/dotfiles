Function Invoke-Build
{
    <#
    .SYNOPSIS
    Build the Visual Studio Solution in the current directory
    .DESCRIPTION
    The Invoke-Build command will run the MSBuild command in the current
    directory to build the .sln file in Debug Mode with minimal output.
    .PARAMETER BuildCommand
    The type of build to run [Build, Rebuild, Clean]
    .PARAMETER Configuration
    What Configuration to build in [Debug, Release]
    .EXAMPLE
    Build in debug mode.
    Invoke-Build
    .EXAMPLE
    Rebuild in Release mode.
    Invoke-Build -BuildCommand rebuild -Configuration Release
    .NOTES
    Default build is debug standard build.
    #>
	Param (
		[Parameter(Mandatory=$False)]
		[String] $BuildCommand = "build",
		[Parameter(Mandatory=$False)]
		[String] $Configuration = "Debug"
	)

	msbuild /verbosity:m /t:$BuildCommand /p:Configuration=$Configuration
}
Set-Alias build Invoke-Build


Function Invoke-RunScripts
{
    <#
    .SYNOPSIS
    Recursively runs all the scripts in the current directory on the
    specified database.
    .DESCRIPTION
    The Invoke-RunScripts command will recursively dive the current directory.
    It then runs each .sql script found using SQLCMD against the DBServer and
    DB supplied in the parameters.
    .PARAMETER ServerName
    The name of the SQL Server Instance to run the scripts against
    .PARAMETER DBName
    The name of the Database on the instance to run the scripts against
    .EXAMPLE
    Run the scripts against the Elite_Cloud Database.
    Invoke-RunScripts -DBName Elite_Cloud
    .NOTES
    The server name will default to ./ if not specified. You will need permissions
    to run the scripts against the database for it to actually work.
    #>
	Param (
		[Parameter(Mandatory=$False)]
		[String] $ServerName = './',
		[Parameter(Mandatory=$True)]
		[String] $DBName
	)

	foreach($item in Get-ChildItem -Recurse -Filter *.sql ) #all current directory child items
	{
		Sqlcmd -S $ServerName -d $DBName -i $item.FullName | Out-String -Stream | %{$list+=$_}
		if($list) #if $list is null
		{
			$item.FullName #print out filename
			$list #print out error message
			$list =$null; #set the output null
		}
	}
}

# Start from user's Workspace
cd ~\workspace

# Use UTF8 code page by default
#chcp 65001

# Get rid of the curl alias so we can install/use real curl
Remove-Item alias:curl

# Use GVim when user launches vim command
Set-Alias vim gvim

# Clear the screen for the user to have a fresh start
clear
