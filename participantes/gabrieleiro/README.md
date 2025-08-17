# Rinha de Backend 2025

O load balancer (HAProxy) envia requests a dois backends por roundrobbin. Assim que os requests chegam no backend, eles são enfileirados em um buffered channel para serem processados posteriormente por uma goroutine livre. A persistência de pagamentos processados é só em memória usando Array of Structs.
