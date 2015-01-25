# gigabit-io-bench

An attempt to identify poor languages that cannot deal with gigabit speeds of disk, network, video or other type of IO.

Slow languages has always had an excuse: they weren't as fast as C, but they were still capable to saturate IO devices.

Here we'll try to identify and put shame on languages that cannot saturate a gigabit link using simple workloads that ought to be IO bound.

## udp-fixed-localhost-flood Benchmark

Send as many UDP datagrams to `127.0.0.1:9999` as possible in 30 minutes. Each datagram should carry 64 Q letters. Output the hardcoded calibration constant (number of datagrams).

1M pps udp @ 64 bytes = 1M * (58 + 64) * 8 = 976 Mbps

Language | Packets | Time | pps | Gbps  
-------- |--------:| ----:| ---:| ----:
Perl     |    100M |  30s |   3M|    3
Node.JS  |     10M |  30s | 0.3M| *0.3*
