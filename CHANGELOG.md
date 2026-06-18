# CHANGELOG — Sistema Filezão

## 2026-06-18 — Login com segurança real (Supabase Auth + RLS)

### index.html
- **Tela de login** ao abrir o sistema (usuário + senha). Sem login válido, nada é carregado.
- Login por **nome de usuário** (sem precisar e-mail): internamente o usuário `fulano` vira `fulano@filezao.app`.
- **Sessão persistente**: depois de entrar, a sessão fica salva e é renovada sozinha (token renovado a cada 45 min). Não precisa logar toda hora.
- **Botão "Sair"** no rodapé da barra lateral, com o nome do usuário logado.
- O cabeçalho de acesso ao banco (`SB_HDR`) agora envia o **token do usuário logado** em todas as operações — assim o banco passa a respeitar quem está logado.
- Boot do sistema travado: `init()` só roda depois do login (ou de restaurar uma sessão válida).

### Supabase (configuração feita por você — ver instruções no chat)
- **RLS ligado** nas tabelas: dados financeiros e operacionais só para usuários logados.
- **produtos**: leitura **pública** (para a TV continuar funcionando) + escrita só para logados.
- **Auto-cadastro desligado**: ninguém se registra sozinho. Os cadastros são criados por você no painel do Supabase.

### Observações
- A TV (`tv.html`) continua funcionando sem login, pois só lê a tabela `produtos`.
