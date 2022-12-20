#
#
# FileName: RunScript remotely
# Ver: .5
# Author:  Lets make this Mr JB :-) 
# Notes:  Look at the sample below on how to use this script.  
#  check out https://www.itprotoday.com/powershell/run-powershell-all-machines-active-directory-group  for more info
#  As always please test new scritps in a controlled group.  
#
#
## The following code shows a very simple use that simply creates a folder on all machines in the passed AD group. 
## Note that the command to run must be placed in double quotes.
## 
## PS C:\Users\administrator\Documents> .\RunCommand.ps1 FileServicesGroup "mkdir 'c:\newtest file3'"


[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true, Position=1)][string]$ADGroupName,
    [Parameter(Mandatory=$true, Position=2)][string]$CommandToRun
)

$ScriptBlockContent = { 
    param ($CommandToRun)
    Invoke-Expression $CommandToRun }

$ADGroupMembers = Get-ADGroupMember -Identity $ADGroupName
foreach ($computer in $ADGroupMembers)
{
    #Run the required command on each computer in the group
    Invoke-Command -ComputerName $computer.name -ScriptBlock $ScriptBlockContent -ArgumentList $CommandToRun

#
