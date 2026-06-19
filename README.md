# 🏥 Hospital Security Monitoring Lab

Laboratório prático de cibersegurança desenvolvido para simular monitoramento, auditoria e proteção de dados em um ambiente hospitalar.

O projeto demonstra como decisões de segurança aplicadas desde a modelagem do banco de dados reduzem riscos de acesso indevido, vazamento de informações sensíveis e ataques de SQL Injection.

---

## 🎯 Objetivos

* Implementar controles de segurança em banco de dados
* Registrar e auditar acessos a informações sensíveis
* Detectar comportamentos suspeitos através de logs
* Demonstrar vulnerabilidades e suas mitigações
* Simular cenários utilizados por equipes SOC e Blue Team

---

## 🔐 Controles de Segurança Implementados

### Auditoria de Acessos

A tabela `LOG_ACESSO` registra:

* Usuário autenticado
* Endereço IP
* Data e hora do acesso
* Operação realizada
* Recursos acessados

Esses registros permitem identificar atividades anômalas e apoiar investigações de incidentes.

### Proteção de Credenciais

O sistema nunca armazena senhas em texto puro.

* Hashing com bcrypt
* Verificação segura de credenciais
* Redução do impacto em caso de vazamento de dados

### Segregação de Dados Sensíveis

Informações médicas foram separadas em tabelas específicas para reduzir exposição desnecessária e aplicar o princípio do menor privilégio.

---

## ⚔️ Laboratório SQL Injection

O projeto contém duas versões da aplicação:

### Aplicação Vulnerável

`app_vuln.py`

Demonstra falhas comuns encontradas em sistemas reais:

* SQL Injection
* Comparação de senhas em texto puro
* Escalada de privilégios

Payload utilizado:

```sql
' OR '1'='1'--
```

### Aplicação Segura

`app_secure.py`

Implementa:

* Queries parametrizadas
* Hash de senhas com bcrypt
* Registro automático de auditoria
* Validação segura de autenticação

---

## 🧪 Resultados dos Testes

| Cenário         | Vulnerável | Seguro      |
| --------------- | ---------- | ----------- |
| Bypass de Login | ✅ Sucesso  | ❌ Bloqueado |
| SQL Injection   | ✅ Sucesso  | ❌ Bloqueado |
| Login Legítimo  | ✅ Sucesso  | ✅ Sucesso   |

---

## 📂 Estrutura

```text
documentos/
aplicativo/
├── app_vuln.py
├── app_secure.py
├── ataques.py

esquema.sql
consultas.sql
esquema.dbml
der.md
```

---

## 🛠️ Tecnologias

* Python
* Flask
* PostgreSQL
* psycopg2
* bcrypt
* GitHub Actions
* Bandit
* Safety

---

## 🚀 Como Executar

1. Criar banco PostgreSQL
2. Executar `esquema.sql`
3. Executar `consultas.sql`
4. Instalar dependências

```bash
pip install flask psycopg2-binary bcrypt requests
```

5. Iniciar aplicações

```bash
python app/app_vuln.py
python app/app_secure.py
```

6. Executar ataques

```bash
python app/ataques.py
```

---

## 👨‍💻 Autor

Victor Silva

Cybersecurity Analyst | SOC | Blue Team

LinkedIn:
https://linkedin.com/in/victor-cyber
