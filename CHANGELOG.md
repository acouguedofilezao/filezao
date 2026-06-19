# CHANGELOG — Sistema Filezão

## 2026-06-18 — Promoção mais bonita: card igual aos outros + tela cheia
- **Card de promoção corrigido:** agora usa o **mesmo layout dos outros produtos** (foto cheia, preço único = o promocional), só com a **borda dourada pulsando** e o selo "🔥 Promoção". Saiu o visual anterior (preço empilhado) que estava apertando a foto.
- **Tela cheia de promoção:** todo produto em promoção ganha uma **tela cheia própria** no rodízio, fora da ordem alfabética — foto grande, "de R$X" riscado e o preço promocional gigante, com borda dourada pulsando, pra forçar a venda.
- **Atualiza sozinho:** quando a promoção vence (ou você desmarca), o produto **para de aparecer em tela cheia** automaticamente (a TV rebusca os dados a cada 1 min) e volta ao preço normal.
- Sem mudança no banco desta vez (usa as colunas `promocao`/`promo_preco`/`promo_ate` já criadas).

## 2026-06-18 — Promoção com preço e data de validade (some sozinha)
- Ao marcar **PROMO** num produto, abre uma telinha pra você definir:
  - **Preço promocional** (campo no estilo caixa registradora).
  - **Data de validade** ("válida até", inclusive).
- Na TV, o produto em promoção mostra o **preço normal riscado** + o **promocional em destaque**, com selo "🔥 Promoção" e borda dourada pulsando, pra forçar a venda.
- **Vence sozinha:** no dia seguinte ao fim da data, a TV já volta a mostrar o preço normal automaticamente, e quando você abre o sistema ele **desmarca** a promoção vencida sozinho (e registra no log "Promoção · Venceu").
- Validações: avisa se a data já passou e confirma caso o preço promocional não seja menor que o normal. Cada ativação/encerramento/vencimento fica no Registro de alterações.
- Na tela de Seleção TV, a linha do produto em promoção mostra o preço promo e o "até dd/mm" embaixo do PROMO.
- **Pré-requisito (uma vez só):** criar as colunas no banco antes de subir (ver instruções no chat). A TV foi feita pra não quebrar mesmo sem as colunas.

## 2026-06-18 — Promoção em destaque na TV + ajustes (fidelidade, rádio)
- **Campo "Promoção" na Seleção TV:** na tela onde você marca os produtos que aparecem na TV, agora tem uma coluna **PROMO**. Ao marcar, o produto aparece na TV com **destaque chamativo**: selo "🔥 Promoção", borda dourada pulsando e a faixa do preço realçada — pra "forçar a venda". A linha do produto em promoção também fica destacada (laranja) no painel de seleção.
  - **Pré-requisito (uma vez só):** precisa criar a coluna `promocao` no banco antes de subir (ver instruções no chat). A TV foi feita pra **não quebrar** mesmo se a coluna ainda não existir.
- **Fidelidade:** texto ajustado para "Acumule pontos a cada compra e troque por desconto e brindes exclusivos" (sem o "em breve"). Os chips agora dizem: 240 pontos = R$ 60, "Cadastre-se 1x grátis no site", "a cada compra os pontos somam sozinhos". O **QR da Fidelidade** agora aponta direto pra tela de cadastro (`/loyalty/phone`), e foi adicionada a observação **"Saiba mais com um de nossos atendentes no caixa"**.
- **Nome da rádio:** agora quebra em até 2 linhas no cabeçalho da TV, então dá pra ler o nome inteiro (antes cortava com "...").

## 2026-06-18 — TV vira um "canal": telas institucionais no rodízio + QR revezando
- A TV agora intercala **telas em tela cheia** entre as páginas de preço (uma tela institucional a cada 2 páginas de produto, 10s cada):
  - **Cartão Fidelidade (a estrela, aparece com mais frequência):** "Clube de Pontos Filezão", gancho de acumular pontos e trocar por desconto (240 pontos = R$ 60) e brindes exclusivos futuros (tábua, faca), com QR pro cadastro no site.
  - **Instagram:** "@acouguedofilezao" + QR pra seguir.
  - **Horário de funcionamento:** Seg–Sex 07h–19h, Sáb 07h–17h, Dom 07h–12h.
  - **Formas de pagamento:** Dinheiro, Pix, Cartão (débito/crédito) — com aviso de que não trabalha com vale-alimentação/voucher.
  - **Endereço:** Av. Luiz Sulino, 35 — Centro, Perdigão/MG, com QR de WhatsApp e o número (37) 3287-0123.
- **QR do canto revezando:** nas páginas de preço, o QR alterna entre **"Acesse nosso site"** e **"Siga no Instagram"** (cada um com o rótulo dizendo qual é, pra ninguém se confundir).
- **Sem produtos selecionados:** em vez de tela vazia, a TV passa a rodar só as telas institucionais (Fidelidade, Instagram, etc.), então nunca fica "morta".
- Tudo client-side, usando o mesmo gerador de QR que já existia (só muda o endereço de cada QR).

## 2026-06-18 — Login: aviso de Caps Lock pequeno (no lugar da caixa grande)
- O aviso de Caps Lock voltou, agora como um **selinho pequeno em amarelo** ao lado da palavra "Senha" ("Caps Lock ativado"). Aparece/some na hora em que você liga ou desliga o Caps Lock no teclado, com qualquer um dos campos (usuário ou senha) em foco. Sem a caixa grande de antes.

## 2026-06-18 — Login: removida a caixa de aviso de Caps Lock
- Tirado o aviso "Caps Lock está ligado" da tela de login (a pedido — estava ocupando muito espaço). O resto da tela continua igual (logo, campos, olho da senha, botão).
- Sem mudança na segurança: a **senha** continua sendo conferida no servidor de forma exata (diferencia maiúscula/minúscula). O **usuário** continua aceitando maiúscula/minúscula (o login usa e-mail por baixo, que não diferencia caixa) — isso não enfraquece nada, porque a trava real é a senha exata.

## 2026-06-18 — Script de sincronização à prova de erro + ajuste no login
- **Correção importante:** as primeiras versões deste script novo fechavam sozinhas no Windows por dois motivos — quebras de linha do Linux (LF) e textos com parênteses dentro de blocos `if(...)`, que o cmd interpretava como fim do bloco. Agora o script está em **CRLF**, **só ASCII** e foi reescrito com etiquetas/`goto` (sem blocos de parênteses), então roda normal e para no fim em "Pressione qualquer tecla".
- **`sincronizar_filezao.bat` repaginado (resolve "não está subindo a versão do PC"):**
  - Mostra a **pasta** onde está rodando e a **data/hora de cada arquivo** (index.html, tv.html, CHANGELOG.md) — se um arquivo estiver com data antiga ou faltando, você vê na hora que ele não foi colado na pasta certa.
  - Passou a usar **`git add -A`** (captura qualquer alteração, não depende de padrão de nome).
  - Mostra o que o Git **detectou de mudança** (`git status`) antes de salvar.
  - Confere se está **dentro do repositório certo** (avisa se o .bat foi parar em outra pasta).
  - No fim, mostra **qual versão (commit) subiu** e lembra do Ctrl+F5 e do "Atualizado" no rodapé.
  - Quando não há nada novo, explica que o arquivo novo provavelmente não está na pasta e mostra o caminho exato pra colar.
- **Login:** o rodapé agora mostra só **"Acesso restrito"** (removido o "Cadastros são liberados só pelo administrador").
- **Confirmação:** o log de importação cobre **cartão e Pix** também (entram como "Entradas · Importou" com o tipo), além dos débitos do Sicoob e cheques — tudo no mesmo fluxo.

## 2026-06-18 — Registro de alterações agora grava as IMPORTAÇÕES + aba da TV renomeada
- **Importações por arquivo passam a ser registradas** no "Registro de alterações" (antes só os lançamentos manuais entravam). Agora dá pra auditar qualquer dado importado e achar onde um lançamento entrou errado:
  - **Extrato Sicoob (financeiro):** cada **entrada** e **saída** lançada pela importação vira um registro (ação azul "Importou", com data, tipo/descrição e valor). Se a importação atualizou um lançamento que já existia, mostra o valor antigo → novo.
  - **Produtos (balança):** além do resumo (+novos/alterados/removidos), agora registra **item por item** — preço novo, **mudança de preço** (antes → depois), renomeação e remoção. É onde costuma esconder erro de preço.
  - **Saldo bancário:** quando o extrato traz um saldo novo/diferente, fica registrado (banco, conta e valor).
  - **Restaurar backup:** passa a registrar que houve uma restauração (e quantos lançamentos vieram), gravando antes de a página recarregar.
  - Por baixo, foi criado um gravador em lote (`logRegBulk`) pra registrar vários itens de uma vez sem pesar no banco. Usa a mesma tabela `logs` que já existe — **não precisa mexer em nada no Supabase**.
- **Aba da TV renomeada:** o título da aba do navegador da tela de preços (`tv.html`) passou de "Casa de Carnes Filezão — Tabela de Preços" para **"#TABELA DE PREÇOS FILEZÃO"**, no mesmo padrão da aba do sistema ("#GESTÃO FILEZÃO").

## 2026-06-18 — Tela de login nova (visual profissional, mesma segurança)
- **Visual repaginado:** fundo escuro com brilho vermelho da marca, cartão centralizado com cabeçalho vermelho, a **logo do boi** (puxada automaticamente do cabeçalho do sistema), título "CASA DE CARNES FILEZÃO" e subtítulo "SISTEMA DE GESTÃO".
- **Campos com ícone:** usuário (boneco) e senha (cadeado), com destaque vermelho ao clicar.
- **Mostrar/ocultar senha:** botão de olho dentro do campo de senha (vira olho cortado quando a senha está visível).
- **Aviso de Caps Lock:** se o Caps Lock estiver ligado enquanto digita usuário/senha, aparece um aviso ("Caps Lock está ligado") pra evitar erro de senha à toa.
- **Botão "Entrar" com estado:** mostra rodinha + "Entrando..." enquanto verifica, e volta ao normal se der erro (não trava nem deixa clicar duas vezes).
- **Mensagens de erro mais claras:** diferencia "Usuário ou senha incorretos." de "Sem conexão com o servidor..." (quando o problema é internet/Supabase fora do ar). Ao errar a senha, o campo é focado e selecionado pra você só redigitar.
- **Enter funciona:** Enter no usuário pula pra senha; Enter na senha já tenta entrar.
- **Segurança:** NÃO mudou nada por baixo — continua Supabase Auth + RLS. Quem confere usuário e senha é o servidor (não dá pra burlar pelo navegador/F12), e só entra quem tem cadastro criado por você. A mudança foi só na aparência e na experiência da tela.

## 2026-06-18 — Campo "Atualizado/Publicado" (saber se o HTML novo já subiu)
- Agora aparece a **data/hora em que a versão do HTML que você está vendo foi publicada** (vem direto do GitHub — automático e preciso).
- **Sistema (index.html):** "Atualizado: dd/mm/aaaa hh:mm" no rodapé da barra lateral.
- **TV (tv.html):** "Publicado dd/mm hh:mm" no rodapé (separado do "Atualizado", que é a hora do último puxão de preços).
- Pra que serve: depois de rodar o script, você atualiza a página (F5); se a hora for recente, é a versão nova; se for antiga, ainda não subiu (espera ~2 min e atualiza de novo).

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
