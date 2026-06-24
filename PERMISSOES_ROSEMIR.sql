-- ============================================================
--  PERMISSAO DA ROSEMIR  -> so a aba "Escala mensal"
-- ============================================================
--  Pre-requisito: a tabela "config" ja precisa existir
--  (se ainda nao criou, rode antes o SQL do CONFIG_ANOTACOES.md).
--
--  Rode UMA vez:  Supabase -> SQL Editor -> New query -> cole -> Run.
--  Depois disso, quando a Rosemir logar, ela so vai ver a aba
--  "Escala mensal" (lancar folga). O resto fica oculto.
--
--  (Voce tambem pode fazer isso sem SQL, pela aba "Permissoes"
--   dentro do sistema: Adicionar usuario "rosemir" -> marcar
--   "Escala mensal" -> Salvar.)
-- ============================================================

insert into public.config (chave, valor)
values ('permissoes', '{"rosemir":["escala"]}')
on conflict (chave) do update
  set valor = excluded.valor, atualizado = now();
