## Monitor CPU usage
```bash
[perfmon://CPU]
interval = 10
object = Processor
counters = % Processor Time
instances = *
index = perfmon
disabled = 0
```

## Monitor Memory usage
```bash
[perfmon://Memory]
interval = 10
object = Memory
counters = Available MBytes, % Committed Bytes In Use, % Usage
instances = *
index = perfmon
disabled = 0
```

## Monitor Disk usage
```bash
[perfmon://LogicalDisk]
interval = 10
object = LogicalDisk
counters = % Free Space, % Disk Time, Current Disk Queue Length
instances = *
index = perfmon
disabled = 0
```
