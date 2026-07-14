# CHANGELOG — Sistema Filezão

## 2026-07-13 — Folha (ajuste): falta faz só PERDER a cortesia, sem tirar 300 do salário
- Corrigido: funcionário com falta perde a cortesia (deixa de ganhar o desconto de R$300 na carne dele), mas NÃO leva 300 de desconto no pagamento. Se não comprou carne, o pagamento não muda por causa disso; se comprou, paga o valor cheio (sem o desconto de até 300). A coluna Cortesia mostra "perdeu por falta".


## 2026-07-13 — Folha: falta faz perder a cortesia da carne (e desconta R$300)
- Funcionário COM cortesia que tiver 1 ou mais faltas na quinzena calculada perde a cortesia e leva R$300 de desconto no pagamento (em vez de ganhar). A coluna Cortesia mostra "-R$300,00 · perdeu (falta)".
- Quem não tem cortesia (Alex) não é afetado. Sem faltas, tudo funciona como antes (resta R$300).


## 2026-07-13 — Painel: topo usa a meta da semana atual
- O número grande "Progresso da Meta" agora usa a meta da semana atual salva por semana (metas_semana) quando existe, caindo para a meta principal (meta_semanal) se não houver. Assim, editar a meta no campo de cima OU no campo da semana atual na lista reflete no painel.
- (Observação: baixar pouco a meta com venda ainda baixa quase não muda a % por arredondamento; a diferença aparece conforme a semana vende mais. Não é erro de cálculo.)


## 2026-07-13 — Meta: marcação manual (3 estados) + carne R$300
- Semanas: no lugar do "automático vira Não", agora tem um seletor por semana com 3 opções: — não marcado / Concluída / Não concluída. Se você NÃO marcar nada, no painel não aparece ✅ nem ❌ na frente (fica só a %). Assim, se a segunda de manhã você ainda não fechou, não aparece "Não" pra equipe.
- Sistema x painel: o sistema já usa a mesma janela deslizante do painel (basta subir este index.html pra ficarem iguais).
- Pagamento de funcionários: a cortesia de carne passou de R$200 para **R$300 por mês** (cálculo e texto de ajuda).


## 2026-07-13 — Importação: fim do conflito de Pix na segunda-feira
- O importador agora reconhece cada Pix pelo FITID (individual). Os Pix já lançados aparecem como "já lançado" e só os que faltam vêm pra marcar.
- Ao lançar, os novos Pix são SOMADOS ao total do dia (não substitui mais) — então lançar o fim de semana de manhã e os Pix reais de segunda à noite não dá mais o aviso de "vai diminuir" nem perde valor.
- Os IDs dos Pix já lançados ficam salvos no aparelho (localStorage). Removido o aviso de "total vai diminuir".


## 2026-07-13 — Semanas: janela deslizante (não zera no vira-mês)
- O quadro de semanas deixou de ser preso ao mês do calendário. Agora é uma janela deslizante: 4 semanas passadas + a atual + 1 futura. Vira a semana, entra uma nova e sai a mais antiga; virar o mês NÃO faz mais as semanas sumirem.
- Aplicado no sistema (edição das metas/concluída) e no painel (a % das semanas passadas continua aparecendo mesmo no mês seguinte).


## 2026-07-11 — Meta: salva a meta de cada semana (a % passada não muda mais)
- No sistema (aba Meta), cada semana do mês agora tem um campo editável de Meta R$. O valor fica salvo por semana (chave metas_semana).
- No painel, a % de cada semana passada usa a meta DAQUELA semana — então mudar a meta atual não altera mais a porcentagem das semanas anteriores. Semana sem meta salva usa a meta atual como padrão.


## 2026-07-11 — Painel: % da semana busca cada semana separada (mais exato)
- A % de cada semana passa a ser calculada buscando as vendas daquela semana separadamente, exatamente como o topo faz pra semana atual — mesma fonte, mesmo resultado.


## 2026-07-11 — Painel: % de cada semana no quadro "Semanas do mês"
- Cada semana passada agora mostra também a **porcentagem que fechou** (vendas da semana ÷ meta, mesmo cálculo do topo), na frente do ✅ Concluída / ❌ Não. Automático — não precisa digitar nada.


## 2026-07-10 — Importação: dia reaberto vem desmarcado
- O último dia já lançado continua reabrindo (pra completar Pix que faltaram), mas agora vem com as caixinhas **desmarcadas** — você marca só o que quiser. Os dias novos continuam vindo marcados normalmente.


## 2026-07-07 — Meta: semanas concluídas no painel (parte 2: painel)
- Na tela da Meta do painel (Área Interna), novo quadro "Semanas do mês" mostrando as semanas que já passaram no mês, cada uma com ✅ Concluída ou ❌ Não — conforme você marca no sistema.
- Só aparecem as semanas que já terminaram; a atual e as futuras não. Quando vira o mês, a lista recomeça.


## 2026-07-07 — Meta: marcar semanas concluídas do mês (parte 1: sistema)
- Na aba Meta/Anotações, novo quadro "Semanas do mês" com as semanas do mês corrente (segunda a domingo) e uma caixinha de concluída pra cada. Marque a que bateu a meta e salve — fica no Supabase pra o painel ler.
- Vira o mês, a lista recomeça sozinha (mostra só as semanas do mês atual). (Parte 2 — exibição no painel da Área Interna — vem quando enviar o areainterna.html.)


## 2026-07-07 — Exportar Excel: colunas com auto-ajuste (nada cortado)
- As colunas de cada aba agora se ajustam ao conteúdo (largura mínima e máxima) e o cabeçalho ganhou um pouco de altura — assim descrições longas de saída, nomes de fornecedor/credor e os títulos não ficam mais "comidos".


## 2026-07-07 — Exportar Excel: abas mensais antigas ficam ocultas
- Na exportação, as abas de fechamento mensal antigas saem **ocultas** — fica visível só a do **mês mais recente** do período. Elas continuam no arquivo (clique direito numa aba → Reexibir pra ver as outras).


## 2026-07-07 — Nova aba "Exportar Excel" (modelo da planilha antiga, com fórmulas)
- Nova aba em Ferramentas: gera um `.xlsx` no mesmo modelo da planilha antiga — abas Entradas, Saídas, Compra de Gado-Porco, Cheques, Saldo diário + uma aba por mês (TOTAL ENTRADA/SAÍDA, calculadora de comissão e SOBRA), tudo com as **fórmulas reais** (SUMIFS, KG×R$, comissão base×%).
- **Base da comissão automática** (mesmo cálculo do Fechamento: líquido − R$2.500 e a cascata Diogo/Alberto/André).
- **Seletor de período** (De → Até, + botão Tudo). O arquivo é montado no navegador (usa ExcelJS, baixado da web na 1ª vez). Cores iguais (verde/vermelho nos totais).


## 2026-07-02 — Gado: R$/kg com preenchimento automático (4 casas)
- O R$/kg voltou a **preencher a vírgula sozinho**, como os outros campos, mas com **4 casas**: digite os números e ele monta (ex.: `216650` vira `21,6650`). Apagar/limpar funcionam normal.


## 2026-07-02 — Gado: R$/kg aceita até 4 casas decimais
- O campo **R$/kg** do gado agora aceita **2 a 4 casas** (ex.: 21,6650). Pode digitar com vírgula ou ponto.
- O valor é guardado com 4 casas, exibido no histórico e no relatório com 2–4 casas, e o **Total** (kg × R$/kg) continua fechando certinho em reais. Os outros campos de dinheiro não mudaram.


## 2026-06-30 — Folha: não lança mais a saída automática
- No Pagamento de funcionários, ao salvar a quinzena o sistema agora **só faz os cálculos e registra a quinzena** (histórico). A **saída não é mais lançada sozinha** — você lança manualmente na aba Saídas, do jeito que preferir.
- Aviso da tela atualizado pra deixar claro.


## 2026-06-30 — Fechamento: ajustar comissão manualmente
- Cada comissão (Diogo/Alberto/André) agora tem um **lápis pra ajustar**: o sistema calcula automático, mas você pode digitar o valor que quiser (ex.: descontar algo). O **Total comissões**, o **Saldo após comissões** e a **Sobra do mês** recalculam sozinhos.
- Mostra a tag "ajustado" e o valor calculado ao lado, e tem botão pra **voltar ao calculado**. O ajuste fica salvo por mês (neste aparelho) e entra no registro de alterações.


## 2026-06-30 — Importação: conferência de Pix por dia (corrige Pix que faltavam)
- Antes, se um dia já tinha QUALQUER Pix lançado, o dia inteiro era escondido — então Pix que faltavam (ex.: os de segunda no dia 29, junto com os do fim de semana que caem no mesmo dia) não entravam.
- Agora o corte é pelo **último dia de Pix lançado**: dias ANTES ficam fechados (não relança — respeita que nem todo Pix é lançado), e o **último dia reabre** pra você completar os Pix que faltaram. Ao lançar, o total daquele dia é atualizado.
- **Trava de segurança:** se um lançamento fizer o total de Pix de um dia DIMINUIR (extrato incompleto), o sistema pede confirmação antes.


## 2026-06-28 — TV: watchdog respeita o anúncio
- Ajuste: quando a rádio pausa pra tocar o **anúncio da loja**, o player **não troca de estação** (antes ele confundia a pausa do anúncio com travamento). Ao acabar o anúncio, a mesma rádio volta normal.


## 2026-06-28 — TV: rádio mais estável (pula sozinha quando falha/trava)
- O player agora **detecta rádio muda/travada** e **pula sozinho pra próxima** (~7s sem tocar). Se clicar em tocar e a estação não funcionar, ele já troca também.
- **Filtro de qualidade** na busca: só estações HTTPS, testadas (sem quebradas), em MP3/AAC e com bitrate decente (≥64). Mais estações na lista (24).
- Voltou pros gêneros **normais** (sertanejo/forró/pagode) — o modo arraiá foi desativado.


## 2026-06-28 — Aniversário: cor roxa + sem nome repetido
- Cor do aniversariante mudou de rosa para **ROXO** (não confunde mais com o vermelho do feriado na TV). Adicionado "Aniversário" na legenda.
- Quando a pessoa tem **folga E aniversário no mesmo dia**, o nome não repete: aparece só como aniversariante (o fundo amarelo continua indicando a folga).


## 2026-06-24 — Painel backup: versão que ESCONDE o valor da meta
- Atualizado o `areainterna_bkp.html` para a versão que **não mostra o valor da meta em R$** — o número grande vira a **porcentagem** (colorida do vermelho ao verde) e o **prêmio/bônus** continua aparecendo. Pra equipe ver o progresso sem ver o alvo em reais.
- Já vem com tudo novo: aniversariante do dia 🎂, anti-sono, calendário com feriados, etc.


## 2026-06-24 — Cheques: botão de Editar (igual Entradas/Saídas)
- Cada cheque agora tem o **lápis de editar** na linha, abrindo um modal pra alterar **emissão, nº, valor, vencimento e credor**.
- **Preserva** situação (Pendente/Compensado), data de compensação e a **Ref. Gado** (não quebra o vínculo com o gado). Tudo fica registrado no log de alterações.


## 2026-06-24 — TV: modo ARRAIÁ (só forró) por hoje 🎉
- Só por hoje, a rádio da TV toca **forró/arraiá** (tags forró/xote/baião + estações de forró). Trava pra não cair nas rádios normais.
- A versão normal foi guardada em **`tv_radios_normais.html`**. Pra voltar amanhã: renomear `tv_radios_normais.html` → `tv.html` e subir pelo `.bat` (ou me pedir que eu devolvo).
- O modo arraiá **não sobrescreve** a rádio normal salva no aparelho, então amanhã volta limpo.


## 2026-06-24 — Aniversário: fonte maior + sem nome repetido
- A escrita "🎂 Aniversariante do dia" + nome ficou **maior** dentro do quadradinho.
- O painel **não repete** mais o mesmo nome no dia (dedupe). E a aba Funcionários agora **remove duplicados** sozinha ao carregar e ao salvar — então o "Magela" repetido some quando você abrir e salvar.


## 2026-06-24 — Quadradinho: frase "Aniversariante do dia"
- No dia do aniversário, a caixinha do calendário agora mostra "🎂 Aniversariante do dia" + o nome (em destaque rosa). Tudo dentro do próprio quadradinho, sem letreiro no topo.


## 2026-06-24 — Aniversário só no quadradinho (letreiro do topo removido)
- A pedido, o letreiro de aniversariantes no topo do calendário foi **removido**. Fica só o destaque no **quadradinho do dia** (contorno rosa + 🎂 + nome).


## 2026-06-24 — Painel: letreiro de aniversariantes do mês 🎂
- Na tela do calendário (Escala), agora aparece um **letreiro** em cima: "🎂 Aniversariantes do mês: NOME (dia)". No dia do aniversário ele muda pra "🎉 HOJE é aniversário de NOME!" com destaque pulsante. (Além do quadradinho rosa + 🎂 que já tinha.)
- Aplicado nas duas versões (EM BREVE e completa).


## 2026-06-24 — Cadastro de funcionários + aniversariante do dia no painel 🎂
- Nova aba **"Funcionários"** (grupo Equipe) no sistema: cadastra **nome + data de nascimento**, salvo central no `config` (chave `funcionarios`). Na 1ª vez sugere os nomes da folha pra só preencher as datas. (A parte financeira NÃO foi mexida.)
- No **painel Área Interna**, no dia do aniversário a célula do calendário ganha **destaque rosa** e mostra **🎂 NOME** (aniversariante do dia). Casa por dia/mês, em qualquer ano. Aplicado nas duas versões (EM BREVE e completa).
- A aba Funcionários entra no controle de Permissões (some pra usuário restrito).


## 2026-06-24 — Área Interna: anti-sono (a tela não apaga mais)
- Adicionado o mesmo "anti-sono" da TV: um vídeo minúsculo invisível em loop + Wake Lock (trava de tela), reativando a cada 1 min. Evita o Fire Stick dormir e cair pra "HDMI"/tela preta.
- Aplicado nas duas versões (EM BREVE e completa/`areainterna_bkp.html`).


## 2026-06-24 — Permissões por usuário (acesso restrito) + aba Permissões
- Novo **controle de acesso por usuário**: aba **"Permissões"** (Administração) onde o Diogo escolhe **quais abas cada usuário vê**. Quem não está na lista = acesso total; quem está = só as abas marcadas (o resto some do menu, junto com o seletor de módulo e o robô da IA). Bloqueio reforçado no `showSec`. Guardado na chave `permissoes` do `config`.
- **Trava de segurança:** usuário `diogo` sempre tem acesso total (não se tranca fora). Sem "flash": permissões carregadas antes de abrir a tela.
- **Rosemir:** preparada pra ter acesso **só à "Escala mensal"**. A conta dela (login Rosemir / senha) é criada no painel do Supabase (a senha **não** vai pro código, repo é público). Permissão via aba Permissões ou `PERMISSOES_ROSEMIR.sql`.
- Não mexeu em nenhuma tabela/coluna existente nem em layout.


## 2026-06-24 — Calendário: dias passados marcados como concluído (✓ verde)
- Todo dia que já passou aparece com um **✓ verde no canto** e o número mais apagado (cara de "concluído"). Nas **folgas que já passaram**, o nome fica **verde** (folga cumprida).
- Aplicado nas **duas versões** (EM BREVE e completa/`areainterna_bkp.html`), pra já vir igual quando você liberar a meta.


## 2026-06-24 — EM BREVE tampa só a Meta (Anotações ficam visíveis)
- Na versão `areainterna.html` (EM BREVE), o "EM BREVE" agora cobre **só a coluna da Meta** (vendas/progresso/bônus). As **Anotações** voltam a aparecer normalmente ao lado, e o calendário segue funcionando.


## 2026-06-24 — Painel Área Interna: versão EM BREVE no ar + backup da completa + manual atualizado
- Criada a versão **EM BREVE** do painel: a tela de **Meta** fica **tapada** com um "EM BREVE" (funcionários veem que vem novidade, mas nenhum valor). O **calendário/escala continua funcionando** normal. **Essa é a `areainterna.html` (a que sobe agora).**
- A versão **COMPLETA** da meta (com os valores) foi guardada como **`areainterna_bkp.html`**. Quando for liberar a meta pros funcionários: renomear `areainterna_bkp.html` → `areainterna.html` e subir pelo `.bat`.
- **Manual (`SISTEMA_FILEZAO_README.md`) atualizado** com tudo do painel Área Interna (meta, escala, feriados, tabela `config`, as duas versões), pra começar conversa nova sem reexplicar.


## 2026-06-22 — Calendário: legenda no topo (não corta mais)
- A **legenda** saiu de baixo (estava cortando) e subiu pro **topo do calendário, ao lado do mês** ("JUNHO 2026"), em tamanho menor pra encaixar. Sobra mais espaço pros dias.


## 2026-06-22 — Painel: fontes maiores (anotação, topo e legenda)
- **Anotação** bem maior, mais fácil de ler de longe.
- **Semana, data e hora** no topo aumentadas.
- **Legenda do calendário** (folga/feriado/sáb-dom/outro mês) aumentada.


## 2026-06-22 — Escala: feriado com cor própria, bolinhas de troca, meses adjacentes e nomes em MAIÚSCULO
- **Cores:** dia de **folga** continua **amarelo**; dia de **feriado** ganhou cor própria (**vermelho clarinho**). Se cair folga num feriado, vale o amarelo da folga e o nome do feriado aparece em vermelho.
- **Bolinhas de troca de tela** no rodapé (igual à TV): clique pra alternar entre Meta e Escala aqui no notebook quando quiser visualizar. Ao clicar, o tempo de 30s reinicia.
- **Meses adjacentes:** quando a semana vira o mês, os dias do mês seguinte (e anterior) aparecem em **cinza bem clarinho**, mostrando que é outro mês. Assim, uma **folga lançada no próximo mês** já aparece no fim do mês atual (e fica verde se for a próxima folga).
- **Nomes em MAIÚSCULO** no painel.
- **Nomes padronizados pela aba de Pagamento de funcionários:** a aba "Escala mensal" agora sugere os nomes exatamente como estão na folha (Alberto, André, Wilson, Magela, Gustavo, Alex) + Diogo e Rosemir. Se você digitar "andre" ou "ANDRÉ", o sistema corrige sozinho pra grafia oficial.


## 2026-06-22 — Calendário de Escala com feriados de Perdigão/MG + sáb/dom
- O calendário da Área Interna agora mostra os **feriados** com o nome dentro do quadradinho: nacionais, o estadual de MG (Tiradentes/Data Magna) e os **municipais de Perdigão** (15/08, 08/12 e 12/12 Aniversário da cidade).
- Os feriados **móveis** (Carnaval, Quarta de Cinzas, Sexta-feira Santa, Corpus Christi) são **calculados automaticamente pela Páscoa** — funcionam em qualquer ano, sem precisar cadastrar. Quando virar o mês/ano, o calendário troca sozinho.
- **Sábado e domingo** agora aparecem com a **coluna em cor diferente** (cinza claro) pra diferenciar. Cabeçalho SÁB/DOM também destacado.
- Quando você preencher as **folgas** no sistema, o nome de quem está de folga aparece no dia (junto com o feriado, se houver). Legenda: De folga hoje / Próxima folga / Feriado / Sáb-Dom.


## 2026-06-22 — Meta: número grande agora é o ALVO (meta estipulada)
- O valor grande em cima agora é a **META que você estipulou** (o alvo a atingir), não o valor atual. Rótulo "Meta da Semana".
- A **barra de progresso** continua mostrando o **valor atual evoluindo** em direção à meta (% concluída/faltante e a cor que fica mais verde quanto mais perto). O bônus segue embaixo.


## 2026-06-22 — Escala: calendário único do mês, branco e maior
- O painel mostra **só o calendário do mês atual** (mesmo com folgas de vários meses cadastradas). Quando virar o mês, troca sozinho pro novo e some o antigo.
- Como é um só, o calendário ficou **bem maior** e em **quadro branco** (fundo branco, datas em destaque) pra enxergar de longe. Folga de hoje em azul, próxima em verde, passadas riscadas, com legenda embaixo.


## 2026-06-22 — Meta: barra por porcentagem com cor de esperança + frase fixa no painel
- Tela da meta agora mostra **o valor + a barra**, sem exibir o valor da meta e sem "faltam R$".
- Abaixo: **% concluída** e **% faltante**. A barra muda de cor conforme a proximidade — **quanto mais perto da meta, mais verde** (sinal de esperança); longe, mais vermelha.
- **Frase fixa** no rodapé do painel: "Deus recompensa quem n'Ele crê e confia." (Hebreus 11:6).


## 2026-06-22 — Correções nas abas Meta/Escala + bônus na TV + calendário de folga
- **Nome corrigido:** Rosmari → **Rosemir**.
- **`meta.html` removido** (não é mais usado; tudo é `areainterna.html`).
- **Aba Meta/Anotações:** campos de dinheiro agora em **R$** no mesmo formato do sistema (digita os centavos), **Enter** salva, e novo campo **Valor da bonificação / brinde (R$)**.
- **Bônus na TV:** aparece em destaque dourado e pulsante ("🏆 Bônus da equipe: R$ X") pra incentivar a equipe.
- **Aba Escala mensal:** **Enter** lança, botão **alterar** (troca de folga), **remover** (com confirmação) e **Apagar todas** (pra virada de mês). Padrão do sistema (toast de confirmação).
- **Painel da escala vira calendário** (SEG→DOM, mês atual + próximo): o nome de quem folga aparece no quadradinho do dia — folga de hoje em **azul**, próxima em **verde**, passadas riscadas.
- **Escala de junho/2026 (da foto)** pronta pra lançar: rode `ESCALA_JUNHO_2026.sql` no Supabase uma vez.


## 2026-06-22 — Painel meta: removida a régua de vendas por dia
- A tela da meta agora mostra só o **VENDAS DA SEMANA** no geral (total da semana + barra da meta + anotações). Tirada a régua que mostrava o valor de cada dia.


## 2026-06-22 — Escala: folgas passadas apagadas + conserto do conflito do CHANGELOG
- Na escala, as **folgas que já passaram** aparecem **apagadas e riscadas**, destacando só o que está por vir (hoje em azul, próxima em verde).
- Arquivo **`corrigir_changelog.bat`**: rode UMA vez pra o git resolver sozinho o conflito do CHANGELOG (mantém sempre a sua versão). Depois disso o sync não trava mais nessa tela.


## 2026-06-22 — Escala: mês atual + próximo, folga de hoje em azul e a próxima em verde
- O painel de escala agora mostra **o mês atual e o próximo** na mesma tela.
- **Quem está de folga hoje** aparece em **azul** (selo "De folga hoje") e **a próxima folga** em **verde** (selo "Próxima folga") — sempre dá pra ver quem tá de folga e quem vai folgar.


## 2026-06-22 — Painel vira "Área Interna" (alterna Meta e Escala) + aba Escala mensal
- **`meta.html` renomeado para `areainterna.html`.** Agora o painel **alterna sozinho a cada 30s**: 30s mostrando **Meta + Anotações**, 30s mostrando **Escala de folga do mês**, e repete. (Deixei um `meta.html` que só redireciona pro novo, pra não quebrar link antigo.)
- **Anotações vazia** aparece em branco (só o título "ANOTAÇÕES", sem texto).
- **Nova aba "Escala mensal"** no sistema: cadastre **nome + dia da folga** (com lista dos funcionários), remova quando quiser; salva na hora. O painel mostra as folgas do **mês atual** numa grade (data · dia da semana · quem folga), com o dia de hoje destacado.
- Se não houver escala cadastrada no mês, o painel **não troca de tela** — fica só na meta.
- Tudo guardado na tabela `config` do Supabase (chaves `meta_semanal`, `anotacoes`, `escala`). Se ainda não rodou o SQL de `CONFIG_ANOTACOES.md`, rode uma vez.


## 2026-06-22 — Meta: semana SEG→DOM, métrica = VENDAS, e meta/anotações vindas do sistema
- **Domingo agora conta:** a semana do painel é de **segunda a domingo** (7 dias), e a régua mostra SEG→DOM.
- **Métrica = VENDAS da semana** (só as entradas, sem as saídas), comparada com a meta. (Antes era saldo.)
- **Meta e anotações deixam de ser fixas:** nova aba **"Meta / Anotações"** no sistema — você digita a meta de vendas e os avisos da semana, clica Salvar, e **aparece no painel automaticamente** (~15s). O painel agora só exibe; a edição é no sistema.
- A meta e as anotações ficam na tabela `config` do Supabase (rode o SQL de `CONFIG_ANOTACOES.md` uma vez).


## 2026-06-22 — Meta: layout pro monitor (Samsung 20" 1600x900) + campo ANOTAÇÕES editável
- **Otimizada pro monitor 16:9** (Samsung SyncMaster 2033, 20", 1600x900): agora em 2 colunas — à esquerda o **saldo da semana + quanto já atingiu** (barra de progresso até a meta), à direita o painel de **ANOTAÇÕES**; embaixo a régua dos dias.
- **ANOTAÇÕES editável:** dá pra escrever os avisos do dia direto na aba da Meta (botão "✎ editar" → Salvar), no lugar de escrever no quadro. A anotação **aparece no monitor** e atualiza sozinha (~15s).
- Para a anotação sincronizar entre o seu celular e o monitor, rode uma vez o SQL em `CONFIG_ANOTACOES.md` (cria a tabela `config` no Supabase). Sem isso, a anotação salva só no aparelho onde foi digitada.


## 2026-06-22 — Nova página: META DA SEMANA (saldo ao vivo)
- Criada a **`meta.html`** — painel em tela cheia (estilo da TV) que mostra o **SALDO DA SEMANA** (entradas − saídas, de segunda a sábado) **atualizando sozinho a cada 15s** conforme você lança no sistema. Tem barra de progresso até a meta, "quanto falta", entradas/saídas da semana e uma régua dia a dia (SEG→SÁB) com o dia de hoje destacado.
- **Botão "Meta da Semana"** adicionado no menu do sistema (abre a página numa aba nova).
- **Meta:** padrão R$ 50.000 (edite em `META_PADRAO` no topo do arquivo) ou pela URL `meta.html?meta=60000` (fica salvo naquele aparelho).
- Usa horário de Brasília. Hospeda em `acouguedofilezao.github.io/filezao/meta.html` depois de subir.


## 2026-06-22 — TV: QR com folga (não encosta em cima nem corta o texto)
- Dei folga no topo do QR (não encosta mais na caixa de cima) e ajustei o tamanho (62%) pra o texto embaixo caber inteiro, sem cortar. Continua sem caixa de fundo e bem maior que o original.


## 2026-06-22 — TV: QR maior e sem caixa de fundo
- Tirei a caixa (fundo, borda e sombra) atrás do QR. Agora é **só o QR com o texto embaixo**, sem moldura, e o QR ficou **bem maior** (de 58% pra 78% da altura). O quadradinho branco em volta do QR foi mantido — é o que faz o celular conseguir ler.


## 2026-06-22 — Celular: botão do menu não fica mais embaixo da barra do iPhone
- O `viewport-fit=cover` (que ativei pra usar a tela toda) jogava o topo do cabeçalho **por baixo da barra de status do iPhone** — e o botão ☰ de abrir o menu lateral ficava escondido, sem dá pra clicar. Agora o cabeçalho **desce pra baixo da barra** (safe-area), e o corpo e a sidebar foram acertados junto pra não desalinhar.


## 2026-06-22 — TV: grade automática (acaba o corte na 2ª fileira de vez)
- **Causa real do corte:** os cards tinham altura fixa em vh (% da tela cheia), mas o cabeçalho e o rodapé comem altura — aí a 2ª fileira passava do limite e a borda de baixo do palco cortava o nome/preço. Troquei pra **grade automática**: o painel mede o espaço que sobra e encaixa as 2 fileiras certinho, sempre. Não importa o tamanho do cabeçalho/rodapé — cabe.
- Mantido o nome grande (4.6vh), preço (5.4vh) e a legenda que não encolhe.


## 2026-06-22 — TV: nome maior e sem cortar embaixo
- **Nome não corta mais embaixo:** a entrelinha estava apertada (cortava o pé das letras com acento, tipo Ç/Ã, e a 2ª linha). Dei respiro na entrelinha (1.06) e **travei a legenda pra nunca encolher** — quem cede espaço agora é a foto, não o texto.
- **Letra maior:** nome subiu de 3.9 → 4.6vh e o preço de 5.0 → 5.4vh. Bem mais legível de longe.


## 2026-06-22 — TV: ajuste de altura (não invade o rodapé) + anúncio de áudio menos frequente
- **Corrigido o estouro:** os cards estavam altos demais (46vh) e a 2ª fileira invadia o QR e o letreiro de baixo. Baixei pra 37vh — agora cabe certinho na faixa entre o cabeçalho e o rodapé, com a letra ainda grande.
- **Anúncio em áudio menos frequente:** a locução da loja (`anuncio.mp3`) tocava a cada 5 minutos e enjoava — agora toca a cada **15 minutos**. Fácil de mudar na linha `FALA_INTERVALO` no script (ex.: `20*60*1000` = 20 min). (Os slides visuais de promoção ficaram como estavam.)


## 2026-06-22 — TV: letra maior pra ver de longe
- **Cards do painel maiores** (preenchem a tela toda; antes sobrava um terço vazio embaixo) e **nome e preço bem maiores** — nome ~56% maior, preço ~67% maior. Categoria, cifrão, unidade e "de/por" também subiram junto.
- **Nome em até 2 linhas:** produto de nome comprido não fica mais cortado.
- Continua 5 produtos por tela; só ficou tudo maior e mais legível à distância.


## 2026-06-22 — IA: apagar/editar/lançar via ferramenta (fim do "fingir que apagou")
- **A IA agora APAGA de verdade.** Antes ela "conversava" sobre apagar e às vezes dizia "excluída" sem ter excluído (ou dizia que não tinha função). Agora adicionar, editar e apagar são **ferramentas que o modelo chama** — o sistema intercepta e mostra o **card de confirmação** (Apagar/Alterar/Confirmar). Sem clique, nada acontece; e a IA não consegue mais alegar que fez algo sem ter chamado a ferramenta.
- **"Apaga o último que lancei"** funciona direto: o sistema lembra o último registro que a IA lançou na conversa (ultimo=true).
- **Ler foto também usa as ferramentas** (comprovante → propõe a saída/entrada pra confirmar).
- **Zoom no celular:** destravei o zoom manual (dá pra abrir tabela larga com os dedos de novo); o auto-zoom ao tocar nos campos continua barrado pelos 16px. Chat da IA ancorado embaixo, perto do botão.


## 2026-06-22 — Celular: fim dos conflitos de zoom
- **Acabou o auto-zoom do iPhone:** os campos passaram a usar fonte de 16px no celular (abaixo disso o iOS aproxima a tela sozinho ao tocar num campo) e o zoom manual ficou travado. Fim do "fica dando zoom toda hora", da barra bugando e do conteúdo saindo pela esquerda.
- **Chat da IA no celular:** agora abre quase em tela cheia, ancorado certinho — não sobe mais por cima das outras coisas.
- **Sem rolagem horizontal** sobrando e respeito às bordas do iPhone (safe-area).


## 2026-06-21 — Backup agora é completo
- O **Baixar backup** passou a salvar **tudo num arquivo só**: entradas, saídas, gado, cheques, **produtos da TV**, cotações, saldos, **saldos diários**, **folha e funcionários**, **energia** e **logs**.
- O **Restaurar** entende todos esses dados e **repõe sem apagar** o que já existe (folha, funcionários e saldos diários entram só o que estiver faltando; o resto é reposto por id).
- Backups antigos continuam funcionando normalmente.


## 2026-06-21 — Visual novo: tema "Bordô institucional"
- **Repaginada completa do visual** do sistema e da **tela de login**, sem mexer em nenhuma função, dado, ID ou estrutura. Só cor, tipografia e acabamento.
- Vermelho vivo deu lugar ao **bordô #8E1B2B** (com hover #5E0F1C); detalhes em **dourado #B8924F**; fundo creme suave; bordas dos cards mais quentes.
- **Cabeçalho** com gradiente bordô e fio dourado embaixo; **menu lateral** escuro com item ativo em dourado.
- **Wordmark "Filezão"** em fonte serifada **Spectral**; subtítulo dourado.
- **Painel:** KPIs com faixa superior colorida (verde nas entradas, bordô nas saídas) e o card de **Saldo** virou destaque em gradiente bordô com valor branco.
- **Login:** fundo bordô profundo, **logo como marca d'água** atrás do cartão, cartão com topo bordô e botão Entrar bordô.

## 2026-06-21 — Filezão IA: acesso total, editar e ler imagem
- **Acesso total à planilha:** a IA agora **pesquisa** qualquer coisa nos dados (datas, valores, vencimentos, fornecedores, totais por período) usando uma ferramenta de busca interna. Pergunte "quanto tenho pra pagar essa semana e quando vence?" que ela acha as datas — não diz mais que "não sabe".
- **Editar/alterar:** peça pra mudar **descrição, valor, data, forma — qualquer campo** de entrada, saída, gado ou cheque ("muda o valor da saída de luz pra 230", "corrige o fornecedor do gado nº 0944"). Mostra **de → para** e só altera depois do seu **Alterar**.
- **Lançar por foto:** toque no **botão da câmera**, mande a foto do **papel de saída / recibo de cartão**, e a IA lê e **propõe o lançamento** na aba certa pra você confirmar.
- Continua tudo com **confirmação** — nada grava, altera ou apaga sem você clicar. Log registra como "Adicionou/Editou/Excluiu (IA)".
- **Fim do "nao consegui responder":** o modelo de texto agora roda com raciocinio minimo (`reasoning_effort: low`) — responde rapido e o texto nunca mais sai vazio. A funcao virou uma ponte que repassa tudo (v3), entao este e o ultimo redeploy dela.
- **Respostas mais firmes:** a conversa passou a usar o modelo `openai/gpt-oss-20b` (mais direto, sem "pensar demais" — acabou o "nao consegui responder"), e a IA agora responde **na hora, do resumo**, quando o dado ja esta a vista (saldo, vendas de hoje, pendentes e vencimentos), usando a busca so pro historico. O qwen ficou so pra ler foto.
- **Mais leve e sem travar no limite:** o pedido pra IA ficou enxuto (ela busca o detalhe em vez de receber um resumão), o "pensar" do modelo foi desligado (`/no_think`) e, se bater no limite grátis do Groq (8000 tokens/min), o sistema **espera e tenta de novo sozinho** em vez de dar erro.
- **Modelo único e à prova de futuro:** tudo (busca, edição e leitura de imagem) roda no **`qwen/qwen3.6-27b`** — o modelo que o Groq indica manter, que lê foto E usa ferramentas. Some o risco do antigo Llama 4 Scout (que estava sendo aposentado) e simplifica: um motor só.
- **Importante:** essas três novidades exigem **redeployar a função `filezao-ia` (v2)** no Supabase (a ponte nova que aceita busca e imagem). Veja o COMO_INSTALAR_IA.md.

## 2026-06-21 — Filezão IA: adicionar E apagar em tudo (com confirmação)
- A IA agora **adiciona** e **apaga** nas 4 tabelas: **entradas, saídas, gado e cheques** — é só pedir em linguagem normal ("lança gado da Frigoserrana, 3 bois, 1500 kg a 12,50", "apaga o cheque nº 426", "exclui a saída de 200 da conta de luz").
- **Sempre com confirmação:** a IA monta a proposta e mostra um card. **Adicionar** → botão verde **Confirmar**. **Apagar** → card vermelho **Apagar**. Nada acontece sem você clicar.
- **Apagar com segurança:** a IA procura o registro pelos dados que você deu e mostra **exatamente qual** vai sair. Se achar **vários parecidos**, ela lista e pede pra você especificar (data/valor/nº) — não apaga no chute. Se não achar, avisa.
- Apagar remove também da **nuvem (Supabase)** e registra no log como **"Excluiu (IA)"**; adicionar registra como **"Adicionou (IA)"**.

## 2026-06-21 — Filezão IA: correção do "gado pendente"
- **Bug:** ao perguntar sobre gado, a IA mostrava um total de pendentes gigante e errado (ex.: 952 compras / R$ 5,7 mi). Motivo: o resumo olhava o campo `pagamento` (que nas compras já pagas guarda a forma/data), contando quase tudo como pendente.
- **Correção:** agora o "em aberto" usa a **mesma regra do painel** (`status === 'PENDENTE'`), batendo com o "Gado a pagar".

## 2026-06-21 — Filezão IA (Fase 2 · lançar com confirmação)
- Agora você pode **pedir pra IA lançar** uma **entrada de venda** ou uma **saída/despesa** em linguagem normal (ex.: "lança saída de 200 conta de luz", "entrada de 1500 no pix hoje").
- A IA **monta a proposta** e mostra um **card com Confirmar / Cancelar**. Nada é gravado sem você clicar em **Confirmar**.
- Ao confirmar, grava igualzinho ao botão "Adicionar" (entra na lista, soma no painel, sincroniza no Supabase) e registra no **log** como "Adicionou (IA)".
- Por enquanto lança **entrada** e **saída**; gado e cheque entram numa próxima.

## 2026-06-21 — TV: caixa do produto menor (foto maior)
- Diminuí a faixa do nome/preço dos cards e reduzi as fontes, sobrando mais espaço pra **foto do produto ficar maior**.

## 2026-06-21 — Sistema: agente "Filezão IA" (Fase 1 · só leitura)
- **Botão flutuante** (robô vermelho, canto inferior direito) disponível em qualquer tela depois que você loga. Clicou, abre um **chat** por cima do sistema; clicou de novo (ou no X), fecha.
- No chat você pergunta em linguagem normal sobre o negócio ("quanto vendi essa semana?", "qual o saldo dos bancos?", "quanto gastei de gado esse mês?", "tenho cheque pra compensar?").
- A IA recebe um **resumo dos seus números** (vendas por mês/dia, saídas, saldos bancários, gado e cheques pendentes) e responde — **sem alterar nada** nesta fase.
- **Motor gratuito (Groq · Llama 3.3 70B), sem cartão.** A chave fica numa **Edge Function do Supabase** (`filezao-ia`), nunca no site. A função só responde pra quem está **logado**. Passo a passo no arquivo `COMO_INSTALAR_IA.md`.
- Próxima fase: a IA poderá **sugerir lançamentos** com **confirmação obrigatória** e registro no log.

## 2026-06-21 — TV: transição cinematográfica + modo "caldo" no clima
- **Transição entre telas:** trocada de slide pra um **dissolve cinematográfico com leve zoom** (mais suave e mais lento), com cara de painel premium.
- **Clima:** quando está **frio (≤ 20°)**, o banner agora sugere **caldo** ("Tá frio? Dia de caldo!" — costela, músculo, ossobuco) em vez de churrasco. Em dia quente de fim de semana continua sugerindo churrasco; nos demais, a mensagem neutra.

## 2026-06-21 — Sistema: correção do relatório "Saldo diário"
- **Bug:** o relatório mostrava **o mesmo saldo em todos os dias**. Motivo: ao importar o OFX, o sistema guardava só **um** número (o saldo final do extrato, `LEDGERBAL`) na data de fechamento — então o relatório repetia esse valor pra frente em todos os dias.
- **Correção:** agora, na importação do OFX, o sistema **reconstrói o saldo de fechamento de cada dia** a partir das transações (parte do saldo final e acumula dia a dia). Cada dia passa a mostrar o saldo real daquele dia.
- **Para preencher o histórico antigo:** reimporte os extratos OFX dos períodos que você quer ver dia a dia (os imports antigos só tinham um saldo cada). Daqui pra frente, todo OFX importado já preenche os dias automaticamente.

## 2026-06-21 — TV: fotos, telas de exclusivo, dots clicáveis e slide nas transições
- **Foto dos produtos:** volta a **preencher o card** (sem fundo preto nem desfocado). A faixa de descrição/preço ficou **menor** (nome em 1 linha) pra **sobrar mais espaço pra carne**.
- **Tela de produto exclusivo (Novidade/Oferta):** **foto bem maior** (60vh) e **nome/preço aumentados**, aproveitando o espaço que sobrava na tela.
- **Selos:** "Novidade da Casa" → **NOVIDADE FILEZÃO** e "Oferta da Casa" → **OFERTA FILEZÃO**.
- **Dots viraram botões:** os pontinhos embaixo agora são **clicáveis** — seleciona pelo controle e **pula direto pra aquela tela**, sem esperar o rodízio. Continuam mostrando a posição atual e o rodízio segue normal depois.
- **Transição em slide:** a troca de telas agora **desliza** (a tela sai pra esquerda e a próxima entra pela direita), tanto no rodízio automático quanto ao clicar num ponto.

## 2026-06-21 — TV: cabeçalho novo, logo maior e rádio repaginada
- **Textos do cabeçalho:** "Seu açougue favorito ♥ • Perdigão/MG" / **Casa de Carnes Filezão** / "Desde 1997 • XX anos de tradição e qualidade • peça pelo nosso delivery". O "XX anos" **atualiza sozinho** (ano atual − 1997).
- **Logo aumentada** (mais presença no topo).
- **Rádio com novo estilo:** virou um módulo de largura fixa com **botões redondos grandes** que **ficam vermelhos quando selecionados** (bem mais fácil de acertar pelo controle da TV). O nome da estação aparece **completo** (em até 2 linhas) e, por ter largura fixa, **os botões não se mexem** ao pausar/trocar. As regras do motor seguem iguais: salva a última rádio, mostra a descrição da estação, etc.

## 2026-06-21 — TV: ajustes finais (bio original, fontes maiores, rádio melhor)
- **Bio de volta ao original:** cabeçalho mostra de novo "Açougue de tradição · Perdigão/MG", **Casa de Carnes Filezão** e "Desde 1997 · X anos de casa · qualidade que você confia" — só que no estilo novo.
- **Fontes maiores** no geral, principalmente no cabeçalho (logo, título, relógio e datas bem maiores), pra ficar legível na TV de longe. Nomes de produto, preços, categorias, clima e rodapé também aumentaram.
- **Rádio:** botões bem **maiores** (fáceis de selecionar pelo controle da TV) e com destaque forte quando selecionados. O nome da estação agora tem largura fixa, então **os botões não se mexem mais** ao pausar ou trocar de estação.

## 2026-06-21 — TV: tela "Sugestão da casa" (Kit) desligada
- A tela do Kit do dia saiu do rodízio (a pedido). Clima e o restante seguem ativos. Pra voltar, `KIT_DIA.ativo=true`.

## 2026-06-21 — TV: cara nova (design "Açougue Premium" do Claude Design)
- Painel inteiro repaginado com a identidade do design que você criou: fundo escuro cinematográfico com **brilho vermelho** animado e textura de linhas, **vermelho #FF1A1A + creme #F3ECE0**, fontes **Anton** (títulos/preços) e **Oswald** (texto), cabeçalho com selo **"ABERTO"** pulsando + relógio, e **dots** animados embaixo.
- **Todo o motor continua igual**: dados do Supabase, rodízio de telas, rádio, anúncio falado, relógio de Brasília, clima + dia de churrasco, kit do dia, QR, keep-awake e teclas da Fire Stick. Só mudou a aparência.
- Cards de produto agora têm cara de "corte premium" (foto grande, nome em Anton, preço vermelho); promoção/novidade viram destaque estilo "OFERTA DA SEMANA"; telas de clima/kit/info repaginadas na mesma identidade.
- Responsivo (não usa tamanho fixo), então escala certinho na TV. Fontes carregadas do Google Fonts.

## 2026-06-21 — Segurança: logout ao fechar a aba + por inatividade (index.html)
- **Novo:** ao **fechar a aba/navegador**, ao reabrir o sistema **pede login de novo** (antes continuava logado mesmo após fechar). Recarregar na mesma aba segue valendo, pra não pedir senha a cada F5.
- A sessão **não fica mais salva pra sempre**. Depois de **15 minutos parado** (sem mexer), o sistema **desloga sozinho** e cai na tela de login. Se alguém pegar seu celular/notebook parado, não entra direto.
- Enquanto você está usando, continua logado normal (a atividade renova o tempo). Mostra "Sessão encerrada por inatividade" no login quando desloga sozinho.
- Pra mudar o tempo: `AUTH_IDLE_MIN` no topo do bloco de login (ex.: 5, 10, 30). Se preferir deslogar **sempre que recarregar**, dá pra trocar — é só pedir.

## 2026-06-21 — TV: vídeos removidos (clima e kit mantidos)
- A tela de **vídeos próprios** foi removida do painel a pedido. Continuam ativas as telas de **Clima + dia de churrasco** e **Kit do dia + carne por pessoa**.

## 2026-06-21 — TV: três telas novas no rodízio (Clima, Kit do dia, Vídeos)
- **Clima + dia de churrasco:** tela com o tempo de Perdigão agora + próximos dias e um aviso forte quando o fim de semana está bom pra churrasco ("Sábado tá pra churrasco!"). Dados da API aberta Open-Meteo (de graça, sem cadastro), no horário de Brasília. Atualiza sozinha a cada 30 min.
- **Kit do dia + carne por pessoa:** tela com um combo de churrasco (editável) e o guia "quanto de carne por pessoa" + tabela rápida (6/10/15/20 pessoas). Pra editar o kit, mexa no `KIT_DIA` lá no topo do `tv.html` (título, itens, preço).
- **Vídeos próprios em loop:** o painel pode tocar seus próprios vídeos (corte, churrasco, bastidores) entre as telas, **sem som** (a rádio continua). Fica desligado até você criar um `videos.json` na pasta do site listando os arquivos. Ex.: `["videos/picanha.mp4","videos/linguica.mp4"]`. Sem copyright, 100% seu.
- As três entram **espaçadas** no rodízio, sem atrapalhar preços e promoções. Clima e Kit já funcionam de cara; vídeo ativa quando você subir os arquivos.

## 2026-06-21 — TV: função de "Notícias / TV ao vivo" removida
- A função de TV ao vivo foi **removida**. Dependia do YouTube/emissora liberar a exibição, o que fica fora do nosso controle e não funcionava de forma confiável. Painel voltou ao foco: preços, rádio e telas da casa.

## 2026-06-21 — TV: painel na identidade da marca (vermelho/branco/preto)
- Painel redesenhado na **identidade da Filezão**: paleta **vermelho (#F40000) + branco + preto**, tirada da própria logo (o boi "FILEZÃO").
- **Logo em destaque no topo** + nome da casa, com uma régua vermelha de marca.
- **Produtos com foto grande** (o herói), nome e preço por cima num degradê elegante. Preço em vermelho, "Oferta" sóbrio nas promoções.
- **Ícone para cada categoria** (boi, porco, frango, peixe, linguiça, espetinho, temperados, kit, laticínio, embutido…) ao lado do nome da categoria.
- **Tratamento igual em todas as fotos** (saturação/contraste/vinheta) pra ficar com cara de catálogo profissional, mesmo com fotos tiradas em luzes diferentes.
- Promoção e novidade em **destaque editorial** com foto grande; telas de info (fidelidade, Instagram, horário, pagamento, endereço) no mesmo padrão limpo, sem emoji.
- Mantém **tudo funcionando**: preços ao vivo do Supabase, rádio, anúncio falado, relógio de Brasília, auto-refresh da Fire Stick e o rodízio de telas. Tipografia Archivo (Google Fonts) com fallback do sistema.

## 2026-06-21 — Energia: contas no mês certo + auditoria mais honesta
- **Convenção da CEMIG aplicada:** a conta "Referente a" um mês é, na verdade, do consumo/geração do **mês anterior** (usa num mês, paga no outro). Agora cada conta cai no mês que ela realmente representa — conta "ABR" → **março**, "MAI" → **abril**, "JUN" → **maio**. Os inversores continuam no mês de calendário deles. Os dados antigos são recarregados automaticamente nessa organização nova.
- **Auditoria de injeção não dá mais "alarme falso" num mês só.** A leitura do medidor pega de uma data a outra (ex.: 16/05 a 17/06), atravessando dois meses de calendário — então num mês isolado a diferença é normal, e um medidor pode até aparecer com energia "a mais" na CEMIG (quando a leitura pegou dias do mês seguinte). Tudo isso explicado na própria tela.
- **Novo: Acumulado por medidor** (só soma os meses em que tem geração E injeção juntas). É esse número que vale como prova contra a CEMIG: quanto mais meses casados, mais o desencontro das datas some na média.
- A auditoria do mês agora só aparece quando dá pra comparar de verdade (tem os dois lados). Quando faltam dados, mostra um aviso explicando o que enviar.

## 2026-06-20 — Roncador: aba Energia (geração solar × consumo)
- Primeira aba da Fazenda Roncador: **Energia**. Cruza a **geração solar** (3 inversores: 2 na casa/Perdigão, 1 na Roça) com o **consumo das contas CEMIG** (4 leitores: Loja 1, Loja 2, Casa e Roça).
- Mostra por mês: quanto **gerou**, quanto **consumiu**, o **saldo** (gerou − gastou) e quanto **pagou** — no **total** (a sobra da Roça e da Casa vira crédito pra Loja 2, então tudo é um pote só), com detalhe **por inversor** e **por conta**, e o **acumulado** desde o início.
- **Histórico mensal** com gráfico de barras (geração × consumo) e tabela.
- **Alertas automáticos**: avisa quando um inversor gera bem abaixo da média (possível defeito) e quando um sistema consome mais do que gera.
- Inversores: Solarman Perdigão, FusionSolar Perdigão, Solarman Roça. Campo de **injeção da CEMIG** por conta + quadro de **auditoria de injeção** (geração dos inversores × injetado registrado pela CEMIG), **por medidor** (Casa = 2 inversores de Perdigão; Roça = inversor da Roça). Dados reais de maio e junho/2026 carregados a partir dos PDFs e fotos. Lançamento por formulário (ou eu preencho). Dados em localStorage + Supabase (tabela `energia`).

## 2026-06-20 — Filezão + Fazenda Roncador (início)
- Cabeçalho agora mostra **FILEZÃO + FAZENDA RONCADOR · Sistema de Gestão** (logo do açougue mantida).
- Novo **seletor na barra lateral** para escolher qual gerenciar: **Filezão** (vermelho) ou **Roncador** (verde).
- O **Roncador entra como espaço separado e vazio** (em construção) — nada do financeiro do açougue foi alterado. As telas da fazenda serão montadas depois.

# CHANGELOG — Sistema Filezão

## 2026-06-19 — Cotações: mínimo de salsicha e coração
- **Salsicha:** mínimo ajustado para **2 kg** (era 5).
- **Coração de frango:** mínimo definido em **6 kg** (1 pacote = 1 kg). Antes ficava "sem mínimo definido".
- O sistema agora entende **"não temos / acabou / faltou"** como estoque **zero** — então um item que o Magela marcou que não tem já cai como abaixo do mínimo (precisa comprar), em vez de "sem mínimo definido".

## 2026-06-19 — TV: anúncio só com a rádio tocando
- O anúncio agora só toca quando a rádio está tocando. Se você pausar/desligar a música, os anúncios param automaticamente (e voltam quando religar a música).

## 2026-06-19 — TV: anúncio mais robusto (destrava no 1º toque)
- Áudio do anúncio destrava no primeiro toque do controle, busca o arquivo novamente (evita "erro" preso em cache) e a primeira fala sai em ~25s pra facilitar o teste.

## 2026-06-19 — TV: anúncio em MP3 (voz igual em todas) + reforço anti-desligamento
- A TV agora toca o arquivo **`anuncio.mp3`** (colocado na pasta do repositório, do lado do `tv.html`) — assim **todas as TVs tocam exatamente a mesma voz**. A cada ~5 min pausa a rádio, toca o anúncio e volta a rádio.
- Texto agora é sobre **novidades** (o diferencial do açougue), não sobre ofertas.
- Se o `anuncio.mp3` ainda não existir, ela usa a voz do navegador como reserva (também falando de novidades).
- **Anti-desligamento reforçado:** o "manter tela ligada" (wake lock + vídeo invisível) agora é re-acionado a cada 1 minuto, ajudando a não cair pra tela azul.

## 2026-06-19 — TV: locução/anúncio falado
- A TV agora **fala um anúncio de tempos em tempos** (voz em português do navegador). A cada ~5 minutos ela **pausa a rádio**, fala a mensagem e **volta a rádio** automaticamente. A primeira fala sai ~1 min depois de ligar.
- **Intercala 3 frases** (baseadas no rodapé: "Casa de Carnes Filezão, o seu açougue favorito... X anos de tradição...") pra não ficar repetitivo. Os anos são calculados sozinhos.
- Se o aparelho não tiver voz em português, ele usa a melhor voz disponível. (Tem como trocar por uma voz gravada se preferir.)

## 2026-06-19 — Folha: abre já na quinzena certa
- Ao abrir a tela de Pagamento, ela já vem no **mês atual** e na **quinzena conforme o dia**: dia 1 a 14 → 1ª quinzena; dia 15 em diante → 2ª quinzena. Vira o mês, volta pra 1ª. (Você ainda pode trocar manualmente pra ver/lançar outra.)

## 2026-06-19 — Folha: trava contra saída duplicada
- Ao salvar a quinzena, se **já existir uma saída com o nome do funcionário naquela data** (dia 1 ou 15), o sistema **não lança de novo** — e abre uma caixa de diálogo avisando quais funcionários foram barrados e por quê.
- A quinzena é salva normalmente; só a saída duplicada é bloqueada. Pra relançar, é só excluir a saída antiga na aba Saídas e salvar de novo.

## 2026-06-19 — Folha: forma de pagamento por funcionário
- A **forma de pagamento agora é por funcionário** (cada linha tem o seu seletor, embaixo do nome): Dinheiro, Pix, Boleto ou Cartão. O sistema **lembra** a forma de cada um pra próxima quinzena.
- Ao salvar, a saída de cada funcionário sai com a forma escolhida pra ele.

## 2026-06-19 — Folha: formato caixa registradora + Enter + saída automática
- **Campos de dinheiro na folha** (salário, extras, vale, carne) agora são **caixa registradora**: você digita da esquerda pra direita e já vem com os centavos (,00) — igual o resto do sistema. (Faltas continua sendo número de dias.)
- **Enter lança:** apertando Enter em qualquer campo, a quinzena é salva (com trava anti-duplicidade, igual as telas de Entradas/Saídas).
- **Mensagem de confirmação** discreta no topo da tela ("✓ Quinzena salva...") ao salvar. Coloquei também nas telas de **Entradas** e **Saídas**.
- **Saída automática:** ao salvar a quinzena, cada funcionário com valor a pagar vira uma **saída** automaticamente — descrição = nome do funcionário, data = dia 1 ou 15, valor a pagar, e a **forma de pagamento** (novo seletor na tela, ao lado do botão Salvar). Re-salvar a mesma quinzena **atualiza** as saídas, não duplica.
  - ⚠️ Como o salário agora entra sozinho na Saída, não precisa mais lançar à mão.

## 2026-06-19 — Extrato bancário diário + confirmação ao mudar categoria
- **Histórico diário de saldo:** agora, todo extrato OFX que você importar, o sistema guarda o **saldo daquele dia** (antes guardava só o último de cada conta). Vai montando o dia a dia automaticamente.
- **Nova aba "🏦 Extrato bancário"** dentro de Relatórios: escolhe o período (igual aos outros relatórios) e ele traz o **saldo de cada dia**, por conta, com **total** quando há mais de uma conta. Nos dias sem importação, repete o último saldo conhecido (marcado com um pontinho · cinza).
- **Confirmação ao mudar categoria:** ao trocar a categoria de um produto, agora aparece uma **caixa de confirmação** (mostra de qual pra qual) — pra não alterar sem querer.
- **⚠️ Rode no Supabase** (pra guardar o histórico na nuvem):
  ```sql
  create table if not exists saldos_dia (
    id text primary key, acctid text, banco text,
    data date, saldo numeric, ts text
  );
  alter table saldos_dia enable row level security;
  create policy "saldos_dia_all" on saldos_dia for all using (true) with check (true);
  ```
  (Sem rodar, o histórico já funciona guardado neste computador.)

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
