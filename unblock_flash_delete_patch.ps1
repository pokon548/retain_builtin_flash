$currentWi = [Security.Principal.WindowsIdentity]::GetCurrent()
$currentWp = [Security.Principal.WindowsPrincipal]$currentWi
 
if( -not $currentWp.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  $boundPara = ($MyInvocation.BoundParameters.Keys | foreach{
     '-{0} {1}' -f  $_ ,$MyInvocation.BoundParameters[$_]} ) -join ' '
  $currentFile = (Resolve-Path  $MyInvocation.InvocationName).Path
 
 $fullPara = $boundPara + ' ' + $args -join ' '
 Start-Process "powershell.exe"   -ArgumentList "$currentFile $fullPara"   -verb runas
 return
}

# 强制卸载 Windows 10 Flash 移除补丁
$Path = [System.Environment]::ExpandEnvironmentVariables("%WINDIR%") + "\servicing\Packages"
$files = Get-Childitem $path -Recurse -Include *KB4577586*.mum

write-host "$files"

foreach ($file in $files)
{
 $content = get-content $file.pspath
  clear-content $file.pspath
   foreach ($line in $content)
   {
   $liner = $line.Replace("permanent","removable")
   Add-content $file.pspath -Value $liner
   }
 }
