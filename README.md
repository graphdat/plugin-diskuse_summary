Boundary Disk Use Summary Plugin
--------------------------------

This plugin scans one or more devices/drives for available disk space as a percentage.
The most used disk will be reported as the measurement.
Although per-disk / per-server graphs may be more complete this plugin aims to help target potential problems as concisely as possible.

### Platforms
- Windows
- Linux
- OS X
- SmartOS

### Prerequisites
- node version 0.8.0 or later
- **Windows Only** - [Drivespace](https://github.com/keverw/drivespace) so the plugin can collect statistics.

### Plugin Setup
**Windows Only** - Ensure that [Drivespace](https://github.com/keverw/drivespace) is in your path. (ex. C:\Windows\System32\drivespace.exe)

### Plugin Configuration Fields
|Field Name|Description                                                                                                                                  |
|:---------|:---------------------------------------------------------------------------------------   -------------------------------------------------|
|Devices   |The set of device mountings to check for free space. On Linux you use the mount path (ex. /). On Windows you use the drive letter (ex. C)|


