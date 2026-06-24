# Meta + Anotações do painel — passo único no Supabase

A **meta da semana** e as **anotações** que você digita no sistema (aba "Meta / Anotações")
ficam guardadas numa tabelinha `config` no Supabase, e o painel da Meta lê de lá.

Rode este SQL **uma vez** (Supabase → SQL Editor → New query → cole → Run):

```sql
create table if not exists public.config (
  chave text primary key,
  valor text,
  atualizado timestamptz default now()
);

grant all on public.config to anon, authenticated, service_role;

alter table public.config enable row level security;
drop policy if exists config_rw on public.config;
create policy config_rw on public.config
  for all to anon, authenticated
  using (true) with check (true);
```

Depois disso: no sistema, abra **Meta / Anotações**, preencha a meta e os avisos, clique
**Salvar** → aparece no painel (monitor) em ~15 segundos.

> Guarda as chaves: `meta_semanal` (meta), `anotacoes` (avisos) e `escala` (folgas do mês). Mesma tabela, não precisa de SQL novo.
> Enquanto a tabela não existir, o sistema avisa que não conseguiu salvar.
