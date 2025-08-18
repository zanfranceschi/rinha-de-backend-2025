// init-index.js
db = db.getSiblingDB('payments'); // substitua pelo nome do seu banco
db.Payment.createIndex({ requestedAt: 1 });