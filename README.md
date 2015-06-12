# Boundary Disk Use Summary Plugin

This plugin scans one or more devices/drives for available disk space as a percentage.

### Prerequisites

#### Supported OS

|     OS    | Linux | Windows | SmartOS | OS X |
|:----------|:-----:|:-------:|:-------:|:----:|
| Supported |   v   |    v    |    v    |  v   |

#### Boundary Meter versions v4.2 or later 

- To install new meter go to Settings->Installation or [see instructons](https://help.boundary.com/hc/en-us/sections/200634331-Installation).
- To upgrade the meter to the latest version - [see instructons](https://help.boundary.com/hc/en-us/articles/201573102-Upgrading-the-Boundary-Meter).

#### For Boundary Meter earlier than v4.2

|  Runtime | node.js | Python | Java |
|:---------|:-------:|:------:|:----:|
| Required |    +    |        |      |

- [How to install node.js?](https://help.boundary.com/hc/articles/202360701)

### Plugin Setup

None

### Plugin Configuration Fields

|Field Name|Description                                       |
|:----------|:------------------------------------------------|
|Disk Name  |The name of the disk to be appended to the hostname to display in the legend for the Disk Use Summary data."|
|Mount Point|The mounted point to check for free space. (either this or the Mounted device need to be set for the plugin to function properly)|
|Device     |The mounted device to check for free space. (either this or the Mount Point directory need to be set for the plugin to function properly)|
|Poll Interval | How often to poll for metrics |

### Metrics Collected

|Metric Name       |Description               |
|:-----------------|:-------------------------|
|Disk Use Summary  |The percentage of disk used for the given mounted disk|

### Dashboards

None

### References

None
