# RinhaBackend2025
RinhaBackend2025 - Serviço de processamento de pagamentos 

Minha ideia é:
- 1.0 - receber a solicitação
- 1.1 - incluir os dados no MemCached para resgate futuro
- 1.2 - incluir o guid em uma fila (em memória) para processamento futuro
- 1.3 - retornar OK
- 2.0 - usar o guid na lista como base para busca do item no MemCached
- 3.0 - tentar enviar o item via API Default
- 3.1 - em caso de falha, enviar via API Fallback
- 4.0 - Salvar os dados de itens enviados e valores no MemCached
- 5.0 - retornar dados solicitados usando lista no MemCached