# !!! We need to change directory because -OutputDirectory of nuget install will ignore the current
# script root !!!
if ($PSScriptRoot.Contains(' ') -and $PSScriptRoot -ne $PWD) {
    throw "This script needs to be executed from inside its folder because white spaces where detected."
}
$root = $PSScriptRoot.Contains(' ') ? '.' : $PSScriptRoot

nuget install devdeer.Templates.Bicep -Source nuget.org -OutputDirectory $root

# remove existing modules and components
if (Test-Path -Path "$root/modules") {
    Remove-Item "$root/modules" -Recurse
}
if (Test-Path -Path "$root/components") {
    Remove-Item "$root/components" -Recurse
}
if (Test-Path -Path "$root/types") {
    Remove-Item "$root/types" -Recurse
}
if (Test-Path -Path "$root/functions") {
    Remove-Item "$root/functions" -Recurse
}
# move items modules and components one level up from the nuget path
Move-Item "$root/devdeer.Templates.Bicep*/modules" $root -Force
Move-Item "$root/devdeer.Templates.Bicep*/components" $root -Force
Move-Item "$root/devdeer.Templates.Bicep*/types" $root -Force
Move-Item "$root/devdeer.Templates.Bicep*/functions" $root -Force
Move-Item "$root/devdeer.Templates.Bicep*/assets/install-modules.ps1" $root -Force
if (!(Test-Path -Path "$root/.gitgnore")) {
    Move-Item "$root/devdeer.Templates.Bicep*/assets/.gitignore" $root -Force
}
if (!(Test-Path -Path "$root/bicepSettings.json")) {
    Move-Item "$root/devdeer.Templates.Bicep*/assets/bicepSettings.json" $root -Force
}
# try to remove the nuget installation package
try {
    Remove-Item "$root/devdeer.Templates.Bicep*" -Recurse -Force -ErrorAction SilentlyContinue
}
catch {
    # probably we are on the build server herebi
    Write-Host "Could not remove nuget installation folder"
}