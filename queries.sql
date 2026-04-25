-- ============================================================
-- Queries de Consulta e Auditoria
-- Projeto: db-security-hospital
-- ============================================================

-- 1. Pacientes do sexo feminino
SELECT * FROM paciente WHERE sexo = 'F';

-- 2. Consultas concluídas
SELECT * FROM consulta WHERE status = 'Concluida';

-- 3. Consultas com nome do paciente e médico
SELECT paciente.nome AS paciente, medico.nome AS medico, consulta.data_hora, consulta.status
FROM consulta
JOIN paciente ON consulta.id_paciente = paciente.id_paciente
JOIN medico ON consulta.id_medico = medico.id_medico;

-- 4. Consultas concluídas do Dr. Ricardo Lima
SELECT paciente.nome AS paciente, medico.nome AS medico, consulta.data_hora, consulta.status
FROM consulta
JOIN paciente ON consulta.id_paciente = paciente.id_paciente
JOIN medico ON consulta.id_medico = medico.id_medico
WHERE consulta.status = 'Concluida' AND medico.nome = 'Dr.Ricardo Lima';

-- 5. Log de auditoria completo
SELECT usuario_sistema.login, id_log, operacao, tabela_acessada, data_hora, ip_origem
FROM log_acesso
JOIN usuario_sistema ON log_acesso.id_usuario = usuario_sistema.id_usuario;

-- 6. Acessos suspeitos (fora do horário comercial)
SELECT usuario_sistema.login, id_log, operacao, tabela_acessada, data_hora, ip_origem
FROM log_acesso
JOIN usuario_sistema ON log_acesso.id_usuario = usuario_sistema.id_usuario
WHERE EXTRACT (HOUR FROM log_acesso.data_hora) < 8
 OR EXTRACT (HOUR FROM log_acesso.data_hora) > 18	