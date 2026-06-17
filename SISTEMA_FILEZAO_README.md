# Sistema Filezão — Documentação Completa de Reconstrução

> **Este documento contém tudo necessário para reconstruir o sistema do zero caso o arquivo seja perdido.**

---

## 1. IDENTIDADE DO PROJETO

| Campo | Valor |
|-------|-------|
| Nome | Sistema de Gestão Casa de Carnes Filezão |
| URL do site | https://acouguedofilezao.github.io/filezao/ |
| Repositório GitHub | https://github.com/acouguedofilezao/filezao |
| Conta GitHub | acouguedofilezao |
| Banco de dados | Supabase |
| Projeto Supabase | acouguedofilezao's Project |
| Supabase URL | https://vfrgqtuvbflkexapdzho.supabase.co |
| Supabase Publishable Key | sb_publishable_mDc22ezigbtBUR30-Fi5yA_sm9rKSX5 |

---

## 2. IDENTIDADE VISUAL

| Elemento | Valor |
|----------|-------|
| Cor principal | #FE0000 (vermelho) |
| Cor fundo | #F5F5F5 (cinza claro) |
| Cor header | #0a0a0a (preto) |
| Cor secundária | #6D0909 (vermelho escuro) |
| Fonte principal | Inter (Google Fonts) |
| Fonte do título FILEZÃO | Locatro (cdnfonts) |
| Logo | Boi vermelho com texto FILEZÃO — arquivo Prancheta_10.png |

---

## 3. ESTRUTURA DO BANCO DE DADOS (Supabase)

### Tabela: `entradas`
```sql
id text PRIMARY KEY
data date NOT NULL
tipo text NOT NULL  -- valores: DINHEIRO, PIX, CARTÃO
valor numeric(12,2) NOT NULL
created_at timestamptz DEFAULT now()
```

### Tabela: `saidas`
```sql
id text PRIMARY KEY
data date NOT NULL
descricao text NOT NULL
valor numeric(12,2) NOT NULL
forma_pgto text  -- valores: DINHEIRO, PIX, BOLETO, CARTÃO
created_at timestamptz DEFAULT now()
```

### Tabela: `gado`
```sql
id text PRIMARY KEY
registro text NOT NULL  -- ex: 0001, 0002
data date NOT NULL
qtd numeric(6,2) NOT NULL
tipo text NOT NULL  -- BOI, VACA, PORCO, NOVILHA, DIANTEIRO, TRASEIRO
kg numeric(10,2) NOT NULL
preco numeric(10,4) NOT NULL
total numeric(12,2) NOT NULL
fornecedor text NOT NULL
status text DEFAULT 'PENDENTE'  -- PENDENTE ou PAGO
pagamento text DEFAULT 'PENDENTE'  -- DINHEIRO, PIX, CHEQUE, BOLETO, MISTO, PENDENTE
formas_pgto jsonb DEFAULT '[]'  -- [{forma: 'DINHEIRO', valor: 100.00}]
cheques jsonb DEFAULT '[]'  -- ['700001', '700002']
cheque text  -- número(s) do cheque separados por vírgula
data_pagamento date
created_at timestamptz DEFAULT now()
```

### Tabela: `cheques`
```sql
id text PRIMARY KEY
data date NOT NULL
numero text NOT NULL
valor numeric(12,2) NOT NULL
vencimento date
credor text
compensado boolean DEFAULT false
data_compensacao date
gado_reg text  -- registro(s) do gado vinculado, ex: "0001,0002"
created_at timestamptz DEFAULT now()
```

### Políticas RLS (Row Level Security)
```sql
-- Todas as tabelas com acesso público (sem autenticação)
CREATE POLICY "acesso_publico" ON [tabela] FOR ALL USING (true) WITH CHECK (true);
```

---

## 4. FUNCIONALIDADES DO SISTEMA

### Abas / Seções
1. **Painel** — resumo do período com filtros rápidos (Hoje/Ontem/Semana/Mês/Anterior/Retrasado)
2. **Entradas** — lançamento e histórico (tipos: Dinheiro, Pix, Cartão)
3. **Saídas** — lançamento e histórico (formas: Dinheiro, Pix, Boleto, Cartão)
4. **Gado** — registro de compras com filtros (Todos/Em aberto/A pagar esta semana/Pagos)
5. **Cheques** — controle com compensação e data de compensação
6. **Fechamento** — cálculo mensal com comissões
7. **Relatórios** — 3 relatórios para WhatsApp

### Regras de Negócio Importantes
- **Decimal automático**: campos de valor funcionam como caixa registradora (digita 5000 = R$ 50,00)
- **Enter lança**: em qualquer campo, Enter confirma o registro
- **Gado — pagamento**: validação obrigatória que soma das formas = total da compra
- **Cheque múltiplo gado**: mesmo cheque pode vincular mais de uma compra de gado (gado_reg separado por vírgula)
- **Abate energia**: R$ 2.500,00 abatidos antes do cálculo de comissões
- **Base comissões**: Math.floor(entrada_liquida - 2500)

### Cálculo de Comissões (Fechamento)
```
Entrada líquida = Total entradas - Total saídas
Base = Math.floor(entrada_liquida - 2500)  ← abatimento energia
Diogo  = Base × 1,5%
Alberto = (Base - Diogo) × 1,625%
André  = (Base - Diogo - Alberto) × 0,875%
Saldo após comissões = Base - Diogo - Alberto - André
Sobra do mês = Saldo após comissões - Total gasto com gado
```

### Relatórios WhatsApp (3 blocos)
1. **SAIDA** (vermelho) — data + descrição + valor de cada saída
2. **ENTRADAS POR DIA** (verde) — data + total do dia
3. **GADO** (azul) — tipo + kg + R$/kg + total + fornecedor + status por compra

---

## 5. LAYOUT E NAVEGAÇÃO

- **Menu lateral (sidebar)** — 220px largura, fundo #0d0d0d, colapsável
- **Botão toggle** — 28×64px, posição fixed na borda do menu
- **Mobile**: sidebar vira overlay e fecha ao navegar
- **Header**: gradiente preto com logo + título FILEZÃO em Locatro
- **Fonte geral**: Inter (400/500/600/700/800)
- **Fonte título header**: Locatro

---

## 6. DADOS HISTÓRICOS IMPORTADOS

- **Período**: fevereiro/2022 até junho/2026
- **Entradas**: 4.504 registros — total R$ 10.601.539,67
- **Saídas**: 6.068 registros — total R$ 3.315.344,09
- **Gado**: 950 registros — total R$ 5.723.873,95
  - 939 pagos (verde na planilha original)
  - 11 em aberto (branco na planilha original)
- **Cheques**: 360 registros
  - 354 compensados (verde na planilha)
  - 6 pendentes
- **Planilha original**: Açougue.xlsm (Excel com macros)
- **Regras de importação**:
  - Verde = PAGO (sem cheque = dinheiro, com cheque = cheque)
  - Amarelo = PAGO mas cheque ainda não compensado
  - Branco = PENDENTE (em aberto)

---

## 7. COMO RECONSTRUIR O SISTEMA

### Passo 1 — Criar arquivo HTML base
O sistema é um **único arquivo HTML** (~1.3 MB) que contém:
- CSS completo inline
- JavaScript completo inline
- Logo embutida em base64
- Ícone iPhone embutido em base64
- Conexão com Supabase via fetch API

### Passo 2 — Conexão Supabase
```javascript
const SB_URL = 'https://vfrgqtuvbflkexapdzho.supabase.co';
const SB_KEY = 'sb_publishable_mDc22ezigbtBUR30-Fi5yA_sm9rKSX5';
```

### Passo 3 — Recriar tabelas no Supabase
Usar o SQL da seção 3 acima no SQL Editor do Supabase.

### Passo 4 — Os dados já estão no Supabase
Os dados históricos já estão salvos no banco — **não precisam ser reimportados**.
O sistema carrega automaticamente do Supabase ao abrir.

### Passo 5 — Publicar no GitHub Pages
1. Criar repositório `filezao` em github.com/acouguedofilezao
2. Fazer upload do `index.html`
3. Ativar GitHub Pages (Settings → Pages → main / root)
4. Site disponível em https://acouguedofilezao.github.io/filezao/

---

## 8. CHANGELOG RESUMIDO

| Versão | Data | Principais mudanças |
|--------|------|---------------------|
| v1-v8 | 17/06/2026 | Sistema base, visual, decimal automático |
| v9 | 17/06/2026 | Reescrita completa, bug exclusão corrigido |
| v10 | 17/06/2026 | Aba Relatórios, dados Maio/26 |
| v11 | 17/06/2026 | Correção Sobra do mês |
| v12 | 17/06/2026 | Lançamentos colapsáveis, dados zerados |
| v13 | 17/06/2026 | Filtro período no painel |
| v14 | 17/06/2026 | Correção navegação e sintaxe JS |
| v15 | 17/06/2026 | Importação planilha completa (fev/22→jun/26) |
| v16 | 17/06/2026 | Integração Supabase, paginação corrigida |
| v17 | 17/06/2026 | Inter font, mobile, 3 relatórios WhatsApp |
| v17.1 | 17/06/2026 | Locatro removida, formato relatório corrigido |
| v17.2 | 17/06/2026 | Logo no header, navbar refinada |
| v17.3 | 17/06/2026 | Menu lateral (sidebar) com toggle |
| v17.4 | 17/06/2026 | Toggle maior, sync na sidebar, ícone iPhone |

---

## 9. CONTATOS E ACESSOS

| Serviço | URL / Acesso |
|---------|-------------|
| Site | https://acouguedofilezao.github.io/filezao/ |
| GitHub | https://github.com/acouguedofilezao/filezao |
| Supabase | https://supabase.com/dashboard/project/vfrgqtuvbflkexapdzho |

---

*Documento gerado em 17/06/2026 — atualizar a cada nova versão do sistema*
