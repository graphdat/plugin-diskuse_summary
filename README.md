Boundary Disk Use Summary Plugin
--------------------------------

This plugin scans one or more devices/drives for available disk space as a percentage.
The most used disk will be reported as the measurement. Although per-disk / per-server graphs may be more complete this plugin aims to help target potential problems as concisely as possible.

### Prerequisites

|     OS    | Linux | Windows | SmartOS | OS X |
|:----------|:-----:|:-------:|:-------:|:----:|
| Supported |   v   |    v    |    v    |  v   |


|  Runtime | node.js | Python | Java |
|:---------|:-------:|:------:|:----:|
| Required |    +    |        |      |

- [How to install node.js?](https://help.boundary.com/hc/articles/202360701)

### Plugin Setup

#### Plugin Configuration Fields

|Field Name|Description                                      |
|:---------|:------------------------------------------------|
|Devices   |The set of device mountings to check for free space. On Linux you use the mount path (ex. /). On Windows you use the drive letter (ex. C)|


