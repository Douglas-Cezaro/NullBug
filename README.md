# API Desafio

Este projeto é para o desafio e fornece uma API para gerenciar contas e transações. Os principais endpoints disponíveis são para criar contas, listar contas, e criar e listar transações associadas a contas.

## Endpoints

### 1. **Criar Conta**

**Endpoint:** `POST /accounts`

**Descrição:** Cria uma nova conta com os parâmetros fornecidos.

**Requisição:**

- **Content-Type:** `multipart/form-data`
- **Parâmetros:**
  - `account[name]` (string): Nome do titular da conta.
  - `account[birth_date]` (string): Data de nascimento no formato `YYYY-MM-DD`.
  - `account[document]` (arquivo): Documento de identificação (imagem).

**Exemplo de Requisição:**

```bash
curl -X POST http://localhost:3000/accounts \
  -F "account[name]=Douglas Cezaro" \
  -F "account[birth_date]=2000-08-10" \
  -F "account[document]=@/path/to/document.png"
```

**Resposta:**

```json
{
	"account": {
		"data": {
			"id": "7",
			"type": "account",
			"attributes": {
				"id": 7,
				"name": "Douglas Cezaro2",
				"birth_date": "0010-08-02",
				"document_url": "/uploads/account/document/7/logo.png"
			}
		}
	},
	"password": "52670f478c8b6504"
}
```

### 2. **Listar Contas**

**Endpoint:** `GET /accounts/{account_id}`

**Descrição:** Lista detalhes da contas.

**Requisição:**

- **Content-Type:** `application/json`

**Exemplo de Requisição:**

```bash
curl -X GET http://localhost:3000/accounts
```

**Resposta:**

```json
{
	"data": {
		"id": "1",
		"type": "account",
		"attributes": {
			"id": 1,
			"name": "Douglas Cezaro",
			"birth_date": "2000-08-10",
			"document_url": "/uploads/account/document/1/logo.png"
		}
	}
```

### 3. **Criar Transação**

**Endpoint:** `POST /accounts/{account_id}/transactions`

**Descrição:** Cria uma nova transação para uma conta específica.

**Requisição:**

- **Content-Type:** `application/json`
- **Parâmetros:**
  - `transaction[transaction_type]` (string): Tipo de transação (`credit` ou `debit`).
  - `transaction[amount]` (decimal): Valor da transação.

**Exemplo de Requisição:**

```bash
curl -X POST http://localhost:3000/accounts/1/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "transaction": {
      "transaction_type": "credit",
      "amount": 100.00
    }
  }'
```

**Resposta:**

```json
{
  "account": {
    "id": 1,
    "name": "Douglas Cezaro",
    "birth_date": "2000-08-10",
    "document_url": "/uploads/account/document/1/logo.png"
  },
  "previous_balance": 1000.0, // exemplo de saldo anterior
  "new_balance": 1100.0 // exemplo de saldo novo
}
```

### 4. **Listar Transações**

**Endpoint:** `GET /accounts/{account_id}/transactions`

**Descrição:** Lista todas as transações de uma conta específica.

**Requisição:**

- **Content-Type:** `application/json`

**Exemplo de Requisição:**

```bash
curl -X GET http://localhost:3000/accounts/1/transactions
```

**Resposta:**

```json
{
  "account": {
    "id": 1,
    "name": "Douglas Cezaro",
    "birth_date": "2000-08-10",
    "document_url": "/uploads/account/document/1/logo.png"
  },
  "transactions": [
    {
      "id": 1,
      "transaction_type": "credit",
      "amount": 100.0,
      "created_at": "2024-08-06T19:00:00Z"
    }
  ],
  "balance": 1100.0 // saldo atual
}
```

## Validações

- **Nome:** Deve ser único e presente.
- **Data de Nascimento:** Deve estar no formato `YYYY-MM-DD`.
- **Documento:** Deve ser um arquivo presente e é obrigatório.

## Dependências

- Ruby on Rails
- Gem `carrierwave` para upload de arquivos

Certifique-se de que todas as dependências estejam instaladas e a aplicação esteja configurada corretamente para testar os endpoints.

