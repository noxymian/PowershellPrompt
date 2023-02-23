#Clear screen
cls

#Display Label
    Write-Host ""
    Write-Host "  00000  0  0     0    0      0000    00 " 
    Write-Host "    0    0  0    0 0   0      0      0  0 " 
    Write-Host "    0    0000   0   0  0      000     0 " 
    Write-Host "    0    0  0   00000  0      0        0 " 
    Write-Host "    0    0  0   0   0  0      0      0  0 " 
    Write-Host "    0    0  0   0   0  0000   0000    00 " 

#UserName variable
$username = Get-ChildItem -Path Env:\USERNAME | Select Name -ExpandProperty value

#Start folder
Set-Location C:\Users\$username\GIT_REPO

# ========================= >

function prompt {

    #Assign Windows Title Text
    $host.ui.RawUI.WindowTitle = "Current Folder: $pwd"

    #Configure current user, current folder and date outputs
    $CmdPromptCurrentFolder = Split-Path -Path $pwd -Leaf
    $CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent();
    $Date = Get-Date -Format "dddd MM/dd/yyyy"
    $Hour = Get-Date -Format "HH:mm:ss"
    $Hostname = $env:COMPUTERNAME

    # Test for Admin / Elevated
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

    #Calculate execution time of last cmd and convert to milliseconds, seconds or minutes
    $LastCommand = Get-History -Count 1
    if ($lastCommand) { $RunTime = ($lastCommand.EndExecutionTime - $lastCommand.StartExecutionTime).TotalSeconds }

    if ($RunTime -ge 60) {
        $ts = [timespan]::fromseconds($RunTime)
        $min, $sec = ($ts.ToString("mm\:ss")).Split(":")
        $ElapsedTime = -join ($min, " min ", $sec, " sec")
    }
    else {
        $ElapsedTime = [math]::Round(($RunTime), 2)
        $ElapsedTime = -join (($ElapsedTime.ToString()), " sec")
    }

    #Decorate the CMD Prompt
    Write-Host "" 
    Write-Host " $date " -ForegroundColor Black -BackgroundColor Yellow -NoNewline
    Write-Host " $Hostname " -BackgroundColor DarkCyan -ForegroundColor White -NoNewline
    Write-host ($(if ($IsAdmin) { 'Elevated ' } else { '' })) -BackgroundColor DarkRed -ForegroundColor White -NoNewline
    Write-Host " USER:$($CmdPromptUser.Name.split("\")[1]) " -BackgroundColor Green -ForegroundColor Black -NoNewline
    If ($CmdPromptCurrentFolder -like "*:*")
        {Write-Host " $CmdPromptCurrentFolder "  -ForegroundColor White -BackgroundColor DarkGray -NoNewline}
        else {Write-Host ".\$CmdPromptCurrentFolder\ "  -ForegroundColor White -BackgroundColor DarkBlue}
    Write-Host " $Hour [$elapsedTime] " -ForegroundColor DarkCyan -NoNewline
    return "> "
} #end prompt function


# ========================= >

# aliases

# Python
New-Alias -Name py -Value C:\Users\$UserName\AppData\Local\Programs\Python\Python311\python.exe




