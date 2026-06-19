# CHANGELOG — Sistema Filezão

## 2026-06-19 — Folha de pagamento (quinzena)
- Nova aba **"Pagamento funcionários"** no menu, do lado do Fechamento.
- Escolhe **mês + ano + quinzena** (1ª dia 1 / 2ª dia 15). Já abre no mês atual (horário de Brasília).
- Para cada funcionário você lança: **faltas**, **extras (R$)**, **vale (R$)** e **compra de carne (R$)**. O sistema calcula o **a pagar** na hora.
- **Cálculo:** salário ÷ 2 − (faltas × salário ÷ 30) + extras − vale − (carne acima da cortesia).
- **Cortesia de carne R$200 = 1× por mês** (pool mensal): só desconta o que passar dos 200. A coluna "Cortesia" mostra quanto foi aplicado e **quanto ainda resta no mês** — registrado, então a 2ª quinzena já sabe se você usou.
- **Alex** entra **sem cortesia** (carne desconta integral). Salários já vêm preenchidos (Alberto 1.770 · André 2.800 · Wilson 2.912 · Magela 3.120 · Gustavo 2.800 com dia extra 150 · Alex 2.000) e são editáveis.
- **Salvar quinzena** grava o fechamento (guarda no aparelho + espelha no Supabase como backup/sincronia).
- **⚠️ Rode no Supabase** (pra salvar na nuvem):
  ```sql
  create table if not exists folha (
    id text primary key, funcionario text, mes text, quinzena int,
    salario numeric, faltas numeric, extras numeric, vale numeric,
    compra numeric, beneficio numeric, valor numeric, ts timestamptz default now()
  );
  alter table folha enable row level security;
  create policy "folha_all" on folha for all using (true) with check (true);
  ```
  (Se ainda não rodar, a folha funciona mesmo assim, guardada neste computador.)

## 2026-06-19 — Campo de categoria (com trava) + aba lateral fixa
- **Categoria do produto:** na tela TV / Produtos, cada produto agora tem um **seletor de categoria** (abaixo do nome/foto). Só dá pra escolher entre as **categorias cadastradas** (lista travada — não dá pra digitar livre, evita ficar fora do padrão). Quando importar o `cad` e vier produto novo, ele entra **sem categoria** (o seletor fica destacado em laranja), aí você escolhe a correta.
- A categoria escolhida manda na TV (agrupamento) e na ordenação, na frente do mapeamento antigo.
- **Aba lateral fixa:** a barra do menu agora fica **fixa** na tela — quando o relatório é grande, o conteúdo rola por dentro e o menu continua sempre visível (não estica mais junto com a página).
- **Salvamento à prova de erro:** se as colunas novas ainda não existirem no banco, o sistema salva o resto mesmo assim (não falha calado).
- **⚠️ Rode no Supabase (quando as gravações estiverem ok):**
  ```sql
  ALTER TABLE produtos ADD COLUMN IF NOT EXISTS categoria text;
  ALTER TABLE produtos ADD COLUMN IF NOT EXISTS lancamento boolean DEFAULT false;
  ```

## 2026-06-19 — Tempo de cada tela ajustado (ciclo mais curto)
- Antes toda tela ficava 10s. Agora o tempo é **por tipo**: tabela de produtos **8s** (dá pra ler), promoção/lançamento **6,5s** (é só uma carne + preço, lê num olhar), institucional **8s** (tempo de escanear o QR). 
- Com isso o ciclo encurtou ~24% — o cliente que fica 1–2 min no açougue e olha de relance pega muito mais coisa, e a promoção (o que vende) volta mais rápido.
- Esses tempos ficam num lugar só no código (`DUR`), fácil de calibrar — se quiser mais rápido/devagar em algum, é só pedir.

## 2026-06-19 — Ajuste fino na frequência da promoção/lançamento
- Tava aparecendo demais (depois de toda página). Coloquei no **meio-termo**: promoção/lançamento a cada **2 páginas** de produtos, com as telas institucionais a cada 3. Aparece com bom destaque, mas sem cansar.

## 2026-06-19 — Promoção/lançamento aparecendo mais + texto novo
- **Aparecem mais vezes:** mudei o rodízio pra mostrar uma tela de **promoção/lançamento depois de CADA página de produtos** (antes era a cada 2, alternando com institucional). Agora, num ciclo, cada promoção e cada lançamento aparece ~2× (antes 1×), sem deixar de mostrar as carnes e as telas de fidelidade/instagram (essas entram a cada 2 páginas).
- **Texto do lançamento:** troquei "Acabou de chegar na Filezão" por **"Novidade exclusiva da Filezão"** — mais moderno e mais certo (não "chegou", é feito aí).

## 2026-06-19 — Economia de dados na TV (resolve o "limite excedido" do Supabase)
- **Causa do limite:** o que estourou foi o **Egress** (dados que saem do Supabase), não o tamanho do banco. A TV rebaixava as **fotos** (base64) de todos os produtos **a cada 60 segundos, 24h por dia** — isso queimava ~3 GB/dia e estourava os 5 GB grátis em 2 dias.
- **Correção:** a atualização de 60s agora puxa **só os preços** (poucos KB). As **fotos são baixadas uma vez** no início e só voltam a ser baixadas quando entra um **produto novo** na TV (mais uma rede de segurança a cada 6h pra pegar troca de foto). Isso corta o egress em ~95%.
- **Resultado:** o gasto cai pra ~1–2 GB/mês (bem abaixo dos 5 GB grátis), e o problema **não volta**.
- **Dica:** se você trocar a foto de um produto e quiser ver na TV na hora, dá **Ctrl + F5** na TV (senão entra sozinho em até 6h).

## 2026-06-19 — Foto da promoção/lançamento sem moldura
- Tirei a **moldura dourada (e a verde do lançamento) ao redor da foto** — ficava pesada. Agora a foto fica limpa, só com cantos arredondados e uma **sombra suave** dando profundidade. O dourado (e o verde) continua **só na borda do quadro todo**, destacando a tela.

## 2026-06-19 — Novo recurso: LANÇAMENTO (produto novo em tela cheia)
- **Campo Lançamento:** ao lado da coluna **PROMO** na tela "TV / Produtos" tem agora a coluna **NOVO**. Marcou um produto como novidade (temperado, kit, etc.), ele ganha uma **tela cheia própria** na TV — igual a promoção, mas com **visual diferente pra chamar ainda mais atenção**.
- **Visual do lançamento:** tema **verde/ciano**, selo **"✨ Novidade ✨"**, borda **piscando** mais forte e mais rápida que a da promoção (alterna pro ciano), foto e preço em moldura verde, e a frase **"Acabou de chegar na Filezão!"**. Diferentão — açougue nenhum tem isso.
- **Como usar:** importa o `cad.txt` normal (o produto novo é criado), aí na tela TV / Produtos é só marcar o **NOVO**. Pra tirar, desmarca. (Promoção e Novidade são independentes; se marcar os dois, ele mostra as duas telas.)
- **Sai do grid:** igual a promoção, o produto marcado como novidade sai da lista alfabética e aparece só na tela cheia dele.
- **⚠️ Precisa rodar 1 SQL no Supabase ANTES de usar** (senão salvar produto dá erro):
  ```sql
  ALTER TABLE produtos ADD COLUMN IF NOT EXISTS lancamento boolean DEFAULT false;
  ```

## 2026-06-19 — Promoção tela cheia dourada + script reconhece entregas parciais
- **Promoção repaginada (tema dourado):** a tela cheia agora tem **borda dourada grossa em volta de tudo** com brilho dourado pulsando, o selo **"🔥 Promoção 🔥" bem maior**, a foto em **moldura dourada** e o preço numa **caixa dourada** (R$ e /kg em dourado, o valor gigante em vermelho). Máximo destaque, cara de oferta de verdade.
- **Script reconhece entrega parcial:** antes ele só extraía o `.zip` se tivesse o `index.html` dentro. Agora reconhece se tiver **`index.html` OU `tv.html` OU `CHANGELOG.md`** — então funciona mesmo quando eu mandar só a TV, só o changelog, ou qualquer combinação (o `CHANGELOG.md` vai em toda entrega, então sempre cai certo).

## 2026-06-19 — Tudo em horário de Brasília (UTC−3)
- **Regra fixa:** toda data/hora — no sistema, na TV e no script — agora usa **horário de Brasília** (`America/Sao_Paulo`), independente do fuso do PC ou da TV (Fire Stick).
- **index.html:** os carimbos de hora dos **logs**, das **cotações salvas** e dos **saldos importados** passam por um formatador novo (`_fmtSP`) fixado em Brasília, com relógio de 0–23h (sem bug de "24:00" à meia-noite).
- **tv.html:** o "Atualizado HH:MM" do rodapé e a checagem de **horário de missa** agora usam Brasília (antes pegavam o fuso do navegador da TV).
- **sincronizar_filezao.bat:** ao copiar os arquivos do `.zip`, ele agora **marca a data do arquivo com a hora local** — então o "editado às" que aparece na tela do script bate com o seu relógio (resolve aquele 03:02 x 00:02).

## 2026-06-19 — Promoção só em tela cheia + tela repaginada + .bat aceita pasta do GitHub
- **Promoção agora aparece SÓ em tela cheia.** Antes o produto em promoção saía em dois lugares (no grid de preços E em tela cheia). Agora ele é **retirado do grid** e mostrado **só na tela cheia própria** dele no rodízio. Sem duplicação.
- **Tela cheia repaginada (nível profissional):** a foto agora fica numa **moldura de tamanho fixo** (não estoura mais "fora do quadrado"), com `object-fit: cover` pra preencher certinho. Layout lado a lado: foto à esquerda; à direita categoria, nome grande, "de R$X /un" riscado, "por R$Y /un" gigante e "Oferta válida até dd/mm". Mantida a borda dourada pulsando. Não usa `aspect-ratio` (compatível com navegador de Fire Stick mais antigo).
- **Script aceita o .zip na pasta do GitHub também:** além de Downloads, o `sincronizar_filezao.bat` agora procura o `.zip` **na própria pasta do sistema**. Salve onde for mais fácil — ele pega o mais recente dos dois lugares.
- **`.zip` não vai pro GitHub:** se você deixar o `.zip` dentro da pasta do GitHub, ele é **desindexado antes do commit** (`git reset -- *.zip`), então fica só local e não polui o repositório.

## 2026-06-18 — Script extrai o .zip sozinho (fluxo "Baixar tudo" + rodar)
- O `sincronizar_filezao.bat` agora, ao rodar, **procura o .zip mais recente na pasta Downloads** (o que o botão "Baixar tudo" gera), **extrai sozinho** e copia os arquivos (`*.html` e `*.md`) pra pasta do sistema — depois sobe pro GitHub normalmente. Não precisa mais extrair na mão.
- Segurança: só age em .zip que contenha o `index.html` (assinatura do sistema); se o .zip não for do sistema, ele ignora e usa o que já está na pasta. Não mexe em mais nada do Downloads.
- O próprio `.bat` **não** é sobrescrito automaticamente (de propósito, pra não corromper o script enquanto roda) — atualizações do `.bat` continuam manuais (são raras).
- Usa o PowerShell do Windows pra extrair (já vem no Windows).

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
