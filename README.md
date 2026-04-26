# db-security-hospital

Projeto desenvolvido durante o curso de Engenharia de Software para demonstrar como segurança de dados pode e deve ser considerada desde a modelagem, não como uma camada adicionada no final.

## Decisões de Segurança

- `LOG_ACESSO` existe desde o modelo conceitual porque auditoria não é opcional em sistemas de dados sensíveis. Com ela é possível monitorar acessos suspeitos, como um login fora do horário de expediente de um IP desconhecido, podendo evitar que virem incidentes de segurança.

- O campo se chama `senha_hash` porque não salva a senha como texto jamais no banco de dados, e sim apenas um hash, evitando que usuários tenham as senhas expostas pelo banco de dados.

- `PRONTUARIO` é uma tabela separada porque se estivesse dentro da tabela `paciente`, todos que tivessem acesso aos dados básicos do paciente também teriam acesso ao histórico médico completo.

## Demonstração Prática

A pasta `app/` conecta a modelagem com a realidade — mostrando o que acontece quando as decisões de segurança são ignoradas ou aplicadas.

**App vulnerável (`app_vuln.py`):**
- Login via SQL injection sem conhecer nenhuma senha
- Atacante obtém acesso de administrador com payload `' OR '1'='1'--`
- Senhas comparadas em texto puro — qualquer vazamento expõe todos os usuários

**App seguro (`app_secure.py`):**
- Queries parametrizadas bloqueiam 100% dos ataques testados
- Senhas verificadas com bcrypt — hash nunca é revertido
- Toda tentativa de login registrada automaticamente no `log_acesso` com IP e timestamp
- Login legítimo continua funcionando normalmente

**Resultado do `ataques.py`:**
```
ATAQUE 1 (bypass)         → app vulnerável: 200 ok  | app seguro: 401 falhou
ATAQUE 2 (usuário específico) → app vulnerável: 200 ok  | app seguro: 401 falhou  
Login legítimo            → app vulnerável: 200 ok  | app seguro: 200 ok
```
## Estrutura do Repositório

- `der.md` — Diagrama Entidade-Relacionamento
- `esquema.dbml` — Modelagem lógica
- `esquema.sql` — Schema SQL com decisões de segurança documentadas
- `queries.sql` — Queries de consulta e auditoria
- `documentos/` — Diagrama visual do schema
- `app/app_vuln.py` — Aplicação vulnerável com SQL injection intencional
- `app/app_secure.py` — Aplicação segura com queries parametrizadas e bcrypt
- `app/ataques.py` — Scripts que demonstram os ataques e as mitigações

## Como Rodar

1. Instale o PostgreSQL e crie o banco: `CREATE DATABASE hospital_security;`
2. Execute `esquema.sql` para criar as tabelas
3. Execute `queries.sql` para testar as consultas de auditoria
4. Instale as dependências: `pip install flask psycopg2-binary bcrypt requests`
5. Em terminais separados, rode:
   - `python app/app_vuln.py` — sobe o app vulnerável na porta 5000
   - `python app/app_secure.py` — sobe o app seguro na porta 5001
6. Execute `python app/ataques.py` para ver os ataques e as mitigações em ação

## Tecnologias

- PostgreSQL 18
- pgAdmin 4
- dbdiagram.io
- Python 3.14
- Flask
- psycopg2
- bcrypt
