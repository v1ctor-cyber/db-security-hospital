# db-security-hospital

Projeto desenvolvido durante o curso de Engenharia de Software para demonstrar como segurança de dados pode e deve ser considerada desde a modelagem, não como uma camada adicionada no final.

## Decisões de Segurança

- `LOG_ACESSO` existe desde o modelo conceitual porque auditoria não é opcional em sistemas de dados sensíveis. Com ela é possível monitorar acessos suspeitos, como um login fora do horário de expediente de um IP desconhecido, podendo evitar que virem incidentes de segurança.

- O campo se chama `senha_hash` porque não salva a senha como texto jamais no banco de dados, e sim apenas um hash, evitando que usuários tenham as senhas expostas pelo banco de dados.

- `PRONTUARIO` é uma tabela separada porque se estivesse dentro da tabela `paciente`, todos que tivessem acesso aos dados básicos do paciente também teriam acesso ao histórico médico completo.

## Estrutura do Repositório

- `der.md` — Diagrama Entidade-Relacionamento
- `esquema.dbml` — Modelagem lógica
- `esquema.sql` — Schema SQL com decisões de segurança documentadas
- `queries.sql` — Queries de consulta e auditoria
- `documentos/` — Diagrama visual do schema

## Como Rodar

1. Instale o PostgreSQL
2. Crie o banco: `CREATE DATABASE hospital_security;`
3. Execute o arquivo `esquema.sql` para criar as tabelas
4. Execute o arquivo `queries.sql` para testar as consultas

## Tecnologias

- PostgreSQL 18
- pgAdmin 4
- dbdiagram.io
