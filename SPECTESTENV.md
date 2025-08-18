# Especificações do Ambiente de Testes

Abaixo estão os detalhes do servidor (gentilmente concedido pelo Luiz Picanço) que rodará os testes. 


Docker
``` 
$ docker --version
Docker version 28.3.3, build 980b856
```

k6
``` 
$ k6 --version
k6 v1.1.0 (commit/0e3fb953be, go1.24.4, linux/amd64)
```

CPU
``` 
$ lscpu
Architecture:             x86_64
  CPU op-mode(s):         32-bit, 64-bit
  Address sizes:          48 bits physical, 48 bits virtual
  Byte Order:             Little Endian
CPU(s):                   4
  On-line CPU(s) list:    0-3
Vendor ID:                AuthenticAMD
  Model name:             AMD EPYC 7R32
    CPU family:           23
    Model:                49
    Thread(s) per core:   2
    Core(s) per socket:   2
    Socket(s):            1
    Stepping:             0
    BogoMIPS:             5599.98
    Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid extd_apicid aperfmperf tsc_known_freq pni pclmulqdq ssse
                          3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy cr8_legacy abm sse4a misalignsse 3dnowprefetch topoext ssbd ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt clwb sha_ni xsaveopt xs
                          avec xgetbv1 clzero xsaveerptr rdpru wbnoinvd arat npt nrip_save rdpid
Virtualization features:  
  Hypervisor vendor:      KVM
  Virtualization type:    full
Caches (sum of all):      
  L1d:                    64 KiB (2 instances)
  L1i:                    64 KiB (2 instances)
  L2:                     1 MiB (2 instances)
  L3:                     8 MiB (1 instance)
NUMA:                     
  NUMA node(s):           1
  NUMA node0 CPU(s):      0-3
Vulnerabilities:          
  Gather data sampling:   Not affected
  Ghostwrite:             Not affected
  Itlb multihit:          Not affected
  L1tf:                   Not affected
  Mds:                    Not affected
  Meltdown:               Not affected
  Mmio stale data:        Not affected
  Reg file data sampling: Not affected
  Retbleed:               Mitigation; untrained return thunk; SMT enabled with STIBP protection
  Spec rstack overflow:   Vulnerable: Safe RET, no microcode
  Spec store bypass:      Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:             Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:             Mitigation; Retpolines; IBPB conditional; STIBP always-on; RSB filling; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                  Not affected
  Tsx async abort:        Not affected
```

Memória
```
$ free -h
               total        used        free      shared  buff/cache   available
Mem:           7.6Gi       728Mi       1.0Gi       2.8Mi       6.2Gi       6.9Gi
Swap:             0B          0B          0B
```

SO (Debian 12.11)
```
$ uname -a
Linux ip-xx 6.14.0-1010-aws #10~24.04.1-Ubuntu SMP Fri Jul 18 20:44:30 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
```
