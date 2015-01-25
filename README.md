# gigabit-io-bench

An attempt to identify poor languages that cannot deal with gigabit speeds of disk, network, video or other type of IO.

Slow languages has always had an excuse: they weren't as fast as C, but they were still capable to saturate IO devices.

Here we'll try to identify and put shame on languages that cannot saturate a gigabit link using simple workloads that ought to be IO bound.

## udp-fixed-localhost-flood Benchmark

Send as many UDP datagrams to `127.0.0.1:9999` as possible. Each datagram should carry 64 Q letters. 

Hardcode the number of datagrams that makes the benchmark last about 30 seconds on your machine. Output the hardcoded calibration constant (number of datagrams).

1M pps udp @ 64 bytes = 1M * (58 + 64) * 8 = 976 Mbps

Language | Packets | Time | pps | Gbps  
-------- |--------:| ----:| ---:| ----:
Perl     |     10M |  30s | 0.3M| *0.3*
Node.JS  |     10M |  30s | 0.3M| *0.3*
Haskell  |    100M |  40s |  30M|    3
