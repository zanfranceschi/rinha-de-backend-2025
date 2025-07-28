Build da versão em rust do participante andersongomes001
https://github.com/andersongomes001/rinha-2025.git
do dia 27/07/2025

Com as flags
```Dockerfile
ENV RUSTFLAGS='-C target-cpu=skylake -C target-feature=+sse4.2,+cx16,+rdrand,+rdseed,+aes,+fma,+avx,+avx2,+bmi,+bmi2,+lzcnt,+popcnt'
```
na teoria com essas flags é gerado um binario otimizado para tirar o maximo do processador usado nos testes `Intel i7 7700`,
localmente não consigo medir o ganho real dessa flags porque tenho um CPU AMD