# Terminal-Icons for your folders and files
# must run: "Install-Module -Name Terminal-Icons -Repository PSGallery"
# as Admin first.
Import-Module -Name Terminal-Icons

# Straight to your wsl $HOME dir
function wsl {
  wsl.exe --cd ~
}

# #OneLetterMatters
function vim ($files) {
  nvim.exe $files
}

# Too used to sudo'it.
function admin {
  if ($args.Count -gt 0) {   
    $argList = "& '" + $args + "'"
    Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
  }
  else {
    Start-Process "$psHome\powershell.exe" -Verb runAs
  }
}
Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin

# Unix'fying ps 
function which ($name) {
  Get-Command $name | Select-Object -ExpandProperty Definition
}
function df {
  get-volume
}
function pkill ($name) {
  Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}
function unzip ($file) {
        Write-Output("Extracting", $file, "to", $pwd)
	$fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object{$_.FullName}
        Expand-Archive -Path $fullFile -DestinationPath $pwd
}
function touch ($file) {
  New-Item $file
}

# Get machine uptime
function uptime {
  Get-WmiObject win32_operatingsystem | Select-Object csname, @{LABEL='LastBootUpTime';
  EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}
}

# PROMPT
# first Install starship https://starship.rs/
Invoke-Expression (&starship init powershell)
# Load custom file
$ENV:STARSHIP_CONFIG = "$HOME\starship.toml"


