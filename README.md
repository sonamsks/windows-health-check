This repository is empty. Any task executed on it should be considered a new capability and needs to be created.

## Health Check Script

The `health_check.ps1` script is a PowerShell script designed to analyze the health of a Windows 11 system based on CPU, memory, disk space, and network utilization. If any of these parameters are less than 60% utilized, the script declares the system as healthy. Otherwise, it declares the system as not healthy.

### Usage

To run the script, open a PowerShell window and execute the following command:

```powershell
.\health_check.ps1
```

To run the script with the "taskManager" argument, which provides an explanation for the health status, use the following command:

```powershell
.\health_check.ps1 -taskManager
```

### Example

Here is an example of running the script with the "taskManager" argument:

```powershell
PS C:\> .\health_check.ps1 -taskManager
Health Status: Not Healthy
Reason: CPU utilization is above 60%. Memory utilization is above 60%.
```
