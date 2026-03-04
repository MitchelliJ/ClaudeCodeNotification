Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
}
"@

$fgWindow = [Win32]::GetForegroundWindow()
[uint32]$fgPid = 0
[Win32]::GetWindowThreadProcessId($fgWindow, [ref]$fgPid) | Out-Null

# Walk up the process tree from this hook process to find if the terminal running Claude is focused
$current = $PID
for ($i = 0; $i -lt 10; $i++) {
    if ($current -eq $fgPid) { exit 0 }  # terminal is focused, skip sound
    $proc = Get-CimInstance Win32_Process -Filter "ProcessId=$current" -ErrorAction SilentlyContinue
    if (-not $proc -or $proc.ParentProcessId -eq 0) { break }
    $current = $proc.ParentProcessId
}

(New-Object System.Media.SoundPlayer 'C:\Windows\Media\chimes.wav').PlaySync()
