param (
    [switch]$taskManager
)

# Function to get CPU utilization
function Get-CPUUtilization {
    $cpu = Get-WmiObject -Class Win32_Processor
    $cpuLoad = $cpu.LoadPercentage
    return $cpuLoad
}

# Function to get Memory utilization
function Get-MemoryUtilization {
    $memory = Get-WmiObject -Class Win32_OperatingSystem
    $totalMemory = $memory.TotalVisibleMemorySize
    $freeMemory = $memory.FreePhysicalMemory
    $usedMemory = $totalMemory - $freeMemory
    $memoryUtilization = ($usedMemory / $totalMemory) * 100
    return $memoryUtilization
}

# Function to get Disk utilization
function Get-DiskUtilization {
    $disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3"
    $totalDiskSpace = $disk.Size
    $freeDiskSpace = $disk.FreeSpace
    $usedDiskSpace = $totalDiskSpace - $freeDiskSpace
    $diskUtilization = ($usedDiskSpace / $totalDiskSpace) * 100
    return $diskUtilization
}

# Function to get Network utilization
function Get-NetworkUtilization {
    $network = Get-WmiObject -Class Win32_PerfFormattedData_Tcpip_NetworkInterface
    $bytesTotalPerSec = $network.BytesTotalPerSec
    $networkUtilization = ($bytesTotalPerSec / 1000000000) * 100
    return $networkUtilization
}

# Get utilization percentages
$cpuUtilization = Get-CPUUtilization
$memoryUtilization = Get-MemoryUtilization
$diskUtilization = Get-DiskUtilization
$networkUtilization = Get-NetworkUtilization

# Determine health status
$healthStatus = "Healthy"
$reason = ""

if ($cpuUtilization -gt 60) {
    $healthStatus = "Not Healthy"
    $reason += "CPU utilization is above 60%. "
}
if ($memoryUtilization -gt 60) {
    $healthStatus = "Not Healthy"
    $reason += "Memory utilization is above 60%. "
}
if ($diskUtilization -gt 60) {
    $healthStatus = "Not Healthy"
    $reason += "Disk utilization is above 60%. "
}
if ($networkUtilization -gt 60) {
    $healthStatus = "Not Healthy"
    $reason += "Network utilization is above 60%. "
}

# Print health status
Write-Output "Health Status: $healthStatus"

# Print reason if taskManager argument is passed
if ($taskManager) {
    Write-Output "Reason: $reason"
}
