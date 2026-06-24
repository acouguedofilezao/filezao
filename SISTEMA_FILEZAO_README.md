# SISTEMA FILEZÃO — Guia mestre (recuperação / handoff)

> **Para que serve este arquivo:** se eu (Diogo) perder a conversa onde isto foi construído, basta abrir um chat novo, enviar **este README + o CHANGELOG.md + o index.html** (e, se for mexer na TV ou na IA, o **tv.html** e o **filezao-ia.index.ts**) e dizer o que quero. Com isso a IA entende todo o contexto e continua de onde paramos.
>
> **Atenção (privacidade):** o repositório é **público**. Por isso este guia NÃO contém números sensíveis (salários, percentuais de comissão, saldos). Esses ficam só dentro do sistema/dados, nunca aqui.

---

## 1. O que é o sistema

Sistema de gestão da **Casa de Carnes Filezão** (açougue em Perdigão/MG, do Diogo). É um **app de um arquivo só** (`index.html`) que roda no navegador, guarda os dados no **Supabase** e fica hospedado de graça no **GitHub Pages**. Tem também um **painel de preços para TV** (`tv.html`) e um **assistente de IA** dentro do sistema (o "Filezão IA").

Tudo é pensado para um usuário **não técnico**, em **português**, com cara de negócio de família.

---

## 2. Onde fica tudo (infra)

- **Site (sistema):** https://acouguedofilezao.github.io/filezao/  → `index.html`
- **Painel TV (preços):** https://acouguedofilezao.github.io/filezao/tv.html  → `tv.html`
- **Painel Área Interna (meta + escala, pros funcionários):** https://acouguedofilezao.github.io/filezao/areainterna.html  → `areainterna.html`
- **Repositório (público):** https://github.com/acouguedofilezao/filezao
- **Pasta local (PC do Diogo):** `C:\Users\Diogo\OneDrive\Documentos\GitHub\filezao`
- **Banco de dados (Supabase):** projeto `vfrgqtuvbflkexapdzho` → URL `https://vfrgqtuvbflkexapdzho.supabase.co`
  - A chave usada no site é a **publishable** (pública por design, protegida por RLS) — já está dentro do `index.html`/`tv.html`. Nada de chave secreta no repositório.
  - **Tabelas:** `entradas`, `saidas`, `gado`, `cheques`, `produtos`, `energia`, `saldos`, `saldos_dia`, `cotacoes`, `logs`, `folha`, **`config`** (chave/valor do painel Área Interna: `meta_semanal`, `bonus`, `anotacoes`, `escala`). (Os funcionários ficam só no aparelho, na chave `fz_func`.)
  - **Edge Function:** `filezao-ia` (é a "ponte" da IA com o Groq — ver seção 7).

---

## 3. Como publicar mudanças (importante)

1. Coloco os arquivos novos num **.zip** e rodo o **`sincronizar_filezao.bat`**.
   - O `.bat` extrai os arquivos `*.html`, `*.md` e `*.mp3` e faz `git add -A` + `commit` + `push` (empurra a pasta inteira pro GitHub).
2. Abro o site e dou **Ctrl+F5** (no Fire Stick da TV, forço atualizar) pra furar o cache.

**Convenção de entrega (quando a IA me manda arquivos):**
- Sempre **`index.html` + `CHANGELOG.md`** juntos.
- **`tv.html`** só quando a TV mudou.
- **Não** mandar `tv_preview.html` por padrão (só se eu pedir).
- Mexeu no painel interno → **`areainterna.html` + `CHANGELOG.md`** (e o backup `areainterna_bkp.html` quando a meta mudar).
- A função da IA (`filezao-ia.index.ts`) só quando ela mudou — e exige redeploy no Supabase (ver seção 7).

---

## 4. Regras de ouro (sempre valem)

- **Fuso de Brasília sempre** (`America/Sao_Paulo`, UTC−3) em qualquer data/hora exibida. Nunca UTC nem o fuso do aparelho. (Há um helper `nowBR()`/`td()` usado em todo lugar.)
- Nada de mexer em lógica/IDs/estrutura quando o pedido é só visual.
- Validar o JS antes de entregar (o `index.html` tem **um** `<script>` gigante; um erro de sintaxe quebra tudo).
- Eu (Diogo) testo **ao vivo** a cada entrega (no sistema e na TV). Zero tolerância a bug ou número errado.

---

## 5. O sistema (`index.html`) — o que tem

- **Login** (Supabase Auth) com tela "Bordô", auto-logout por inatividade.
- **Entradas** (vendas: Dinheiro / Pix / Cartão), **Saídas** (despesas), **Gado** (compras, pago/pendente), **Cheques** (a compensar/compensado).
- **Fechamento mensal** com comissões em camadas e dedução de energia (percentuais e valores ficam **no código**, não aqui).
- **Pagamento** de gado/cheques, com baixa.
- **Saldo bancário** + **importador de extrato OFX** (Sicoob, com lógica de débito, cheques, baixa automática e reconstrução do **saldo de cada dia** → tabela `saldos_dia`) e importador **CSV (Sipag)**.
- **Cotações** (comparar preço de fornecedor; guardadas no aparelho e no backup).
- **Energia** (custos pro fechamento) e **Folha/Funcionários** (salários e pagamentos).
- **Relatórios** (incl. extrato por período) e **WhatsApp** formatado.
- **Backup e segurança** (ver seção 8).
- **Tema "Bordô institucional"** (vinho `#8E1B2B`, dourado `#B8924F`, fonte Spectral) aplicado em tudo, incluindo o login com a logo em marca d'água.

---

## 6. O painel TV (`tv.html`)

Mostra os preços dos produtos numa TV (Fire Stick), com:
- Fotos dos produtos, telas de "Novidade Filezão" / "Oferta Filezão", transição em dissolve, relógio de Brasília, clima (com modo "Dia de caldo" no frio), rádio e anúncios em áudio.
- **Busca os produtos no Supabase a cada 1 minuto** (`REFRESH_MS=60000`). Isso, na prática, **mantém o Supabase acordado** sozinho enquanto a TV está ligada (ver seção 9).

---

## 6.1 O painel "Área Interna" (`areainterna.html`)

Painel de TV **interno** (pros funcionários), separado do `tv.html` de preços. Mesmo visual escuro (preto/vermelho/dourado, fontes Anton/Oswald, logo). Tela cheia, **alterna a cada 30s** entre duas telas, com **bolinhas no rodapé** pra trocar manualmente (igual à TV). Usa fuso de Brasília (`agoraBR()`), `HDR` (só apikey+Authorization), atualiza dados a cada 15s.

**Tela 1 — META DA SEMANA**
- Número grande em cima = **o VALOR DA META estipulada** (o alvo), não o atual. Rótulo "Meta da Semana".
- **Barra de progresso** mostra o **atual evoluindo** rumo à meta: % concluída e % faltante, cor **vermelho → verde** conforme chega perto. Não mostra o valor atual em número. "✓ META BATIDA!" quando alcança.
- **Bônus** (banner dourado pulsante) aparece só se houver bônus definido.
- **Anotações** (recados da equipe) na coluna da direita. Semana = segunda a domingo; vendas = só entradas (sem saídas).

**Tela 2 — ESCALA DE FOLGA (calendário do mês)**
- Calendário branco do **mês atual** (troca sozinho ao virar o mês), segunda→domingo.
- **Folga** = dia **amarelo** com o(s) nome(s) em MAIÚSCULO. **Hoje** = azul, **próxima folga** = verde, passadas marcadas com **✓ verde (concluído)** e número apagado (folga passada = nome verde).
- **Feriados** com o nome, em vermelho clarinho: nacionais + estadual MG (Tiradentes/Data Magna) + **municipais de Perdigão** (15/08, 08/12 e 12/12 Aniversário). Os **móveis** (Carnaval, Quarta de Cinzas, Sexta-feira Santa, Corpus Christi) são **calculados pela Páscoa** (`pascoa()`+`feriadosDoAno()`) → funcionam em **qualquer ano** sozinhos.
- **Sábado/domingo** com a coluna em cinza; dias do **mês seguinte/anterior** aparecem em **cinza bem claro** ("outro mês") — assim uma folga lançada no próximo mês já aparece no fim do mês atual.
- **Legenda** no topo, ao lado do nome do mês (foi pra cima pra não cortar).

**Onde os dados vêm:** tabela **`config`** no Supabase (chave text PK, valor text, atualizado timestamptz): `meta_semanal`, `bonus`, `anotacoes`, `escala` (JSON `[{nome,data}]`).

**Quem preenche (no `index.html`):**
- Aba **"Meta / Anotações"** (`sec-metaedit`, função `metaCfgSave`) → grava `meta_semanal`, `bonus`, `anotacoes`.
- Aba **"Escala mensal"** (`sec-escala`, `escalaSave`) → grava `escala`. Os **nomes sugeridos vêm da aba de Pagamento de funcionários** (`funcGet()`: Alberto, André, Wilson, Magela, Gustavo, Alex) + Diogo e Rosemir; e o sistema **corrige a grafia sozinho** (`nomeCanonico()`: digitar "andre" vira "André"). No painel os nomes saem em MAIÚSCULO.

**SQL necessário (rodar 1x no Supabase):** criar a tabela `config` → está no **`CONFIG_ANOTACOES.md`**. Pra lançar a escala de junho/2026 da foto, há o **`ESCALA_JUNHO_2026.sql`** (opcional). Sem a tabela `config`, salvar a meta/escala avisa erro.

**Duas versões do arquivo (IMPORTANTE):**
- **`areainterna.html`** = versão **EM BREVE**: só a **coluna da Meta** (vendas/progresso/bônus) fica **tapada** com um "EM BREVE" — os funcionários veem que vem novidade, mas **nenhum valor**. As **Anotações continuam visíveis** e o **calendário/escala funciona** normal. **É a que está no ar agora.**
- **`areainterna_bkp.html`** = versão **COMPLETA** da meta (com os valores reais). Guardada de backup. **Quando o Diogo for liberar a meta pros funcionários, é só renomear `areainterna_bkp.html` → `areainterna.html` e subir pelo `.bat`.**

---

## 7. A IA "Filezão IA"

**O que faz:** botão flutuante (robô, canto inferior direito, aparece depois do login). Ela:
- **Responde perguntas** sobre o negócio (vendas, saldos, gado/cheques pendentes, vencimentos, etc.).
- **Busca** qualquer coisa na planilha (ferramenta `consultar_planilha`, sobre as tabelas em memória).
- **Adiciona, edita e apaga** lançamentos (entradas, saídas, gado, cheques) — **sempre com um card de confirmação**; nada grava sem eu clicar. Registra no log como "Adicionou/Editou/Excluiu (IA)".
- **Lê foto** (botão da câmera): mando a foto de um comprovante/papel de saída e ela **propõe o lançamento** pra eu confirmar.

**Como funciona por dentro:**
- A IA NÃO chama o Groq direto (a chave não pode ficar no site público). Ela chama a **Edge Function `filezao-ia`** no Supabase, que guarda o segredo `GROQ_API_KEY` e repassa o pedido pro **Groq** (grátis, sem cartão).
- A função atual é uma **ponte que repassa tudo** (v3) — não precisa mais ser editada; qualquer ajuste futuro de parâmetro passa sozinho.
- **Modelos (no `index.html`, fáceis de trocar — são 2 constantes):**
  - Texto/busca: `IA_MODEL_TEXTO = 'openai/gpt-oss-20b'`
  - Imagem/foto: `IA_MODEL_VISAO = 'qwen/qwen3.6-27b'`
  - Observação: o Groq **aposenta modelos de tempos em tempos** (ex.: Llama 3.3 70B e Llama 4 Scout foram aposentados em jun/2026). Se um modelo parar de funcionar, é só **trocar a constante** pelo equivalente atual do Groq.
- **Limite do plano grátis do Groq:** ~8.000 tokens por minuto. Por isso o sistema: manda o pedido **enxuto** (resumo curto + busca só quando precisa), usa **`reasoning_effort: low`** no texto (resposta rápida, sem "pensar demais"), **espera e tenta de novo sozinho** quando bate no limite (429), e deixa as instruções **fixas** pra o Groq cachear (cache não conta no limite).
- **Setup da IA:** ver **`COMO_INSTALAR_IA.md`** (pegar chave grátis no console.groq.com, criar/colar a função `filezao-ia`, guardar o segredo `GROQ_API_KEY`). Ao atualizar o código da função, é só **Edit → colar → Deploy** no Supabase; a chave continua a mesma.

---

## 8. Backup

- Aba **Backup → Baixar backup**: gera um arquivo `backup-filezao-AAAA-MM-DD.json` com **tudo**: entradas, saídas, gado, cheques, **produtos da TV**, cotações, saldos, **saldos diários**, **folha e funcionários**, **energia** e **logs** (formato `versao 2`).
- **Restaurar de um backup**: lê o arquivo e **repõe sem apagar** o que já existe.
- Recomendação: baixar **um por semana** e guardar no Google Drive / e-mail. O plano grátis do Supabase **não tem backup automático**, então esse arquivo é a real proteção contra perda de dados.

---

## 9. "Robozinho" que mantém o Supabase acordado

- O plano grátis do Supabase **pausa o projeto após 7 dias sem atividade** (os dados não somem; é só religar, mas fica fora do ar até lá).
- No dia a dia **não é problema**: a TV cutuca o banco a cada 1 minuto e o sistema é usado todo dia.
- Como **seguro para fechamento longo** (férias/reforma com a TV desligada), existe um **GitHub Actions** (`.github/workflows/keepalive.yml`) que faz uma leitura levíssima no banco **1x por dia**, sozinho e de graça. (Já está instalado e testado.)

---

## 10. Estado atual / pendências

- ✅ Tema Bordô aplicado (sistema + login).
- ✅ Filezão IA: pergunta, busca, adiciona, edita, apaga (com confirmação) e lê foto.
- ✅ Backup completo + restauração.
- ✅ Robozinho keep-alive instalado.
- ✅ Painel **Área Interna** (meta + escala/calendário com feriados) pronto. No ar a versão **EM BREVE** (meta tapada); a **completa** está em `areainterna_bkp.html`.
- ⚠️ **Rodar 1x no Supabase:** o SQL da tabela `config` (`CONFIG_ANOTACOES.md`) — sem ela, a Meta/Escala não salva. (Escala de junho: `ESCALA_JUNHO_2026.sql`, opcional.)
- 💡 Pra **liberar a meta**: renomear `areainterna_bkp.html` → `areainterna.html` e subir.
- ⚠️ **Vigiar:** o Groq pode aposentar modelos — se a IA reclamar de "modelo não encontrado", trocar `IA_MODEL_TEXTO`/`IA_MODEL_VISAO`.
- ⚠️ **Limite grátis do Groq** (8.000 tokens/min): em rajada de muitas perguntas no mesmo minuto, a IA pausa uns segundos e se recupera. Pra tirar o teto, existe o **Dev Tier** do Groq (pague-o-que-usar, centavos/mês pro volume do açougue).
- 💡 Ajuste opcional "na gaveta": rodar o texto com **`reasoning_effort: low`** + função **v3** (já documentado) caso volte a aparecer "não consegui responder".

---

## 11. Como retomar numa conversa nova (passo a passo)

1. Abra um chat novo.
2. Anexe: **este `SISTEMA_FILEZAO_README.md`**, o **`CHANGELOG.md`** e o **`index.html`** atual. (Se for mexer na TV, anexe o `tv.html`; no painel interno, o `areainterna.html`; na IA por dentro, o `filezao-ia.index.ts`.)
3. Diga algo como: *"Esse é o meu sistema Filezão, leia o README e o CHANGELOG pra entender tudo. Quero que você faça X."*
4. Pronto — o contexto inteiro estará ali, e dá pra continuar sem reexplicar nada.

---

*Última atualização deste guia: 24/jun/2026 (inclui o painel Área Interna: meta + escala/calendário com feriados, versão EM BREVE no ar). Mantenha-o junto do CHANGELOG.md — os dois contam, juntos, toda a história do sistema.*
