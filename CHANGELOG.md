# CHANGELOG — Sistema Filezão

## 2026-06-18 — Importador: baixa de cheque automática + descrição editável
- **Cheque compensado dá baixa sozinho:** quando um cheque aparece compensado no extrato, o sistema casa pelo **número** (ignorando zeros à esquerda) com o cheque que você lançou e, ao clicar em Lançar, marca ele como **compensado** na tela de Cheques. O cheque deixa de aparecer como "saída" (não conta duas vezes).
  - Mostra uma seção **CHEQUES** no preview: ✓ "vai dar baixa" (casou), ou "não encontrado" (se o cheque não estiver lançado, aí é só lançar e reimportar).
  - **Cheque que você já compensou manualmente** antes é **descartado** automaticamente (não aparece pra refazer); fica só um aviso no rodapé de quantos foram descartados.
- **Descrição da saída editável:** como a descrição que você digita no Pix **não vem no extrato**, agora dá pra **editar o texto da saída** ali na lista antes de lançar (ex.: trocar para "QUEIJO ROCA"). O que você digitar é o que vai pro lançamento.

## 2026-06-18 — Importador de extrato: oculta débitos de dias já fechados
- No importador do **Sicoob (OFX)**, a lista de **SAÍDAS (débitos)** agora só mostra os débitos de **dias mais novos** que você ainda não trabalhou.
- A regra (estrita): esconde uma saída **somente se você já lançou algo num dia POSTERIOR** a ela. Assim o último dia que você lançou continua visível (dá pra terminar de marcar), e os anteriores em aberto somem.
- Como você lança o cartão/pix todo dia, essa "data de corte" avança sozinha; não precisa configurar nada.
- Link discreto **"mostrar"** (e "ocultar") caso um dia você precise rever os débitos de dias já fechados.
- **Descrição da saída** corrigida: agora mostra o **destino/favorecido** do Pix/transferência (campo NAME do extrato, ex.: "PANIFICADORA SAO JOSE LTDA"), em vez do tipo genérico ("DÉB.TRANSF..."). Quando não há destinatário no arquivo (ex.: cheque), mantém a descrição do tipo. Removido o prefixo "FAV.:".

## 2026-06-18 — Horário de Brasília fixo (TV + sistema)
- **tv.html:** o relógio agora mostra sempre o **horário de Brasília (UTC−3)**, ignorando o fuso configurado no aparelho (Fire Stick estava em UTC, mostrando 3h a mais).
- **index.html:** a função de "hoje" (`td()`) e os padrões de data/mês/ano do painel passaram a seguir Brasília também (novo helper `nowBR()`), pra toda a base usar o mesmo horário.
- Os carimbos de data/hora internos (`ts`) continuam em UTC ISO (padrão técnico), o que é o correto — a mudança é só no que você vê e nos padrões de data.
- Observação: isso corrige o **fuso**. O relógio absoluto do aparelho precisa estar mais ou menos certo (com internet, ele sincroniza sozinho).

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
