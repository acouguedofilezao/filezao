# Filezão — Histórico de Alterações

## v17 — 17/06/2026
- Fonte alterada para **Inter** (padrão de apps modernos)
- Relatório diário com **3 blocos separados para WhatsApp** (Saída, Entrada por dia, Gado)
- Cores dos blocos: Saída = vermelho, Entrada = verde, Gado = azul
- Layout **responsivo para celular** (formulários, tabelas, modais)
- Cheque agora suporta **múltiplos vínculos de gado** no mesmo cheque
- Ordem dos cheques: pendentes primeiro, compensados do mais recente para o mais antigo
- Relatório de gado com formato de tabela para WhatsApp
- Seletor de relatórios (Abate / Diário / Compras de Gado)

## v16 — 17/06/2026
- Integração com **Supabase** (banco de dados em nuvem)
- Dados salvos online — acessível de qualquer dispositivo
- Paginação corrigida (carrega todos os registros, não só 1000)
- Ordenação do mais recente para o mais antigo em Entradas e Saídas

## v15 — 17/06/2026
- Importação de todos os dados da planilha Excel (fev/2022 → jun/2026)
- 4.504 entradas, 6.068 saídas, 950 compras de gado, 360 cheques
- Gado: verde = pago dinheiro, amarelo = cheque pendente, branco = em aberto
- Cheques compensados (verdes na planilha) marcados automaticamente
- Sistema de versão para forçar reimportação quando necessário

## v14 — 17/06/2026
- Correção crítica: navegação entre abas funcionando (fix closest nav-btn)
- Correção de sintaxe JS (template literals corrompidos no fechamento)
- renderFech reescrito sem template literals para evitar erros

## v13 — 17/06/2026
- Painel: filtro de período com atalhos (Hoje, Ontem, Semana, Mês, Anterior, Retrasado)
- Data do painel preenche automaticamente ao abrir

## v12 — 17/06/2026
- Lançamentos do painel virou caixa colapsável (Mostrar/Ocultar)
- Sobra do mês movida para depois das comissões no Fechamento
- Dados zerados para testes

## v11 — 17/06/2026
- Correção do cálculo da **Sobra do mês**
- Fórmula correta: Saldo após comissões − Total gasto com gado
- Math.floor() na base das comissões (igual à planilha original)

## v10 — 17/06/2026
- Aba **Relatórios** criada
- Relatório de Abate (Boi/Vaca e Porco por período)
- Dados de Maio/2026 pré-carregados da planilha para comparativo

## v9 — 17/06/2026
- Sistema reescrito do zero para corrigir bug de exclusão
- Exclusão: lógica nova com `_sel` no objeto (sem Set, sem comparação de tipo)
- Botão **Editar** em Entradas e Saídas
- Filtros de Gado: Todos / Em aberto / A pagar esta semana / Pagos
- Saídas: formas de pagamento reduzidas (Dinheiro, Pix, Boleto, Cartão)
- Cheques: modal de compensação com campo data de compensação
- Painel repaginado com cards de métricas, gado a pagar e cheques

## v8 — 17/06/2026
- Identidade visual aplicada (cores #FE0000, #000000, #F7F7F7)
- Fechamento repaginado com hierarquia visual clara
- Tentativas de correção do bug de exclusão

## v7 — 17/06/2026
- Fonte Locatro aplicada nos elementos de identidade visual
- Correção de navegação entre abas

## v6 — 17/06/2026
- Decimal automático modo **caixa registradora** em todos os campos de valor
- Digita 5000 → exibe 50,00
- Enter em qualquer campo lança o registro
- Painel com filtro de período (De / Até) e atalhos rápidos

## v5 — 17/06/2026
- Caixas de seleção para excluir múltiplos registros
- Pagamento de gado: validação de que total lançado bate com valor da compra
- Modal de pagamento com formas livres e acumuláveis (Dinheiro + Pix + Cheque etc.)
- Fechamento simplificado (sem cálculo de comissão quando negativo)

## v4 — 17/06/2026
- Dados zerados para início limpo
- Correção de bug do Set na seleção de registros
- Campos de valor sem type=number (preparação para decimal automático)
- Log de data de pagamento no gado
- Suporte a múltiplos cheques no pagamento de gado

## v3 — 17/06/2026
- Forma de pagamento adicionada em Saídas
- Pagamento de gado: suporte a Misto (Dinheiro + Cheque)
- Múltiplos cheques por pagamento de gado
- Registro de data de pagamento ao dar baixa no gado
- Fechamento: apenas Entrada Líquida e Total Gado

## v2 — 17/06/2026
- Decimal com 2 casas em todos os campos de valor e kg
- Enter em Entradas lança automaticamente
- Exclusão via checkbox com barra de seleção

## v1 — 17/06/2026
- Sistema visual completo: Painel, Entradas, Saídas, Gado, Cheques, Fechamento
- Fundo branco, menu preto, destaque vermelho #C8102E
- Decimal automático nos campos monetários
- Filtros no Gado: Todos / Em aberto / Pagos
- Formas de pagamento: Dinheiro, Pix, Boleto, Cheque, Misto
- Cálculo de comissões: Diogo 1,5%, Alberto 1,625%, André 0,875%
- Armazenamento em localStorage

---
*Sistema desenvolvido para Casa de Carnes Filezão*
*Banco de dados: Supabase | Hospedagem: GitHub Pages*

## v17.1 — 17/06/2026
- Fonte Locatro removida completamente do sistema (100% Inter)
- Relatório diário: formato corrigido para WhatsApp (data + descrição + valor por linha)
- Blocos dos relatórios com bordas coloridas e altura fixa sem scroll
- Botão Copiar dentro do cabeçalho colorido de cada bloco

## v17.2 — 17/06/2026
- Header repaginado com gradiente preto/vermelho e linhas sutis
- Logo do Filezão embutida no header (fundo preto removido, brilho vermelho)
- Título FILEZÃO em fonte Locatro (só o header, resto permanece Inter)
- Divisor vermelho entre logo e texto
- Navbar mais refinada com fundo escuro e transições suaves
- Relatório de saídas: altura dinâmica (sem cortar descrições longas)
- Relatório de gado: adicionado data, fornecedor, status e cheque por compra
- Fontes: Locatro removida de todo o sistema exceto título do header

## v17.3 — 17/06/2026
- Menu lateral (sidebar) substituiu navbar horizontal — igual ao OnBeef
- Botão ◀▶ para esconder/mostrar o menu lateral
- No mobile: sidebar vira overlay e fecha automaticamente ao navegar
- Seções do menu agrupadas: Menu (Painel/Entradas/Saídas/Gado/Cheques) e Financeiro (Fechamento/Relatórios)

## v17.4 — 17/06/2026
- Botão de toggle do menu aumentado (28x64px, mais fácil de clicar no celular)
- Status "Pronto — X entradas" movido para o rodapé da sidebar (oculta com o menu)
- Ícone da logo adicionado para tela inicial do iPhone (apple-touch-icon 180x180)
- Meta tags para PWA no iPhone (barra de status preta, título Filezão)

## v17.5 — 17/06/2026
- Ícone do app atualizado: logo do boi em transparência + cifrão branco + borda vermelha
- Fundo preto puro (sem cinza) no ícone da tela inicial do iPhone
