# Como ligar o agente "Filezão IA" (de graça, com Groq)

O chat **já está dentro do sistema** (um **botão flutuante** do robô, no canto inferior direito, que aparece depois que você loga). Falta só ligar o "motor" gratuito. Você faz isso **uma vez**, leva ~10 min e **não precisa de cartão**.

## 1) Pegar a chave grátis do Groq (sem cartão)
1. Entre em **console.groq.com** e faça login (pode ser com e-mail, Google ou GitHub).
2. Vá em **API Keys** → **Create API Key** → dê um nome (ex.: "filezao") → **copie** a chave (começa com `gsk_...`).
   - **Não cole no site nem me mande aqui.** Ela vai só dentro do Supabase.
   - É grátis. O Groq não pede cartão e **não usa seus dados pra treinar**.

## 2) Criar a função no Supabase
1. Entre no painel do seu projeto Supabase (`vfrgqtuvbflkexapdzho`).
2. Menu lateral → **Edge Functions** → **Create a new function** (ou "Deploy a new function").
3. Nome da função: **`filezao-ia`** (exatamente assim).
4. Apague o exemplo e **cole todo o conteúdo do arquivo `filezao-ia.index.ts`** que te entreguei.
5. Clique em **Deploy**.

## 3) Guardar a chave como segredo
No painel do Supabase:
- **Edge Functions** → **Secrets** (ou **Manage secrets**) → **Add new secret**.
- Nome: `GROQ_API_KEY`
- Valor: cole a chave `gsk_...`
- Salvar.

(Pelo terminal, se preferir: `supabase secrets set GROQ_API_KEY=gsk_...`)

## 4) Testar
1. Abra o sistema, faça login normalmente.
2. Clique no **botão flutuante do robô** (canto inferior direito).
3. Pergunte: **"Quanto vendi essa semana?"** ou clique num dos botões de exemplo.

Pronto. 🎉

---

## Detalhes importantes
- **Segurança:** a chave do Groq fica **só no Supabase**, nunca no site. A função só responde pra quem está **logado** no Filezão (usa seu login). Como o Groq é grátis, mesmo no pior caso **não há cobrança** — no máximo um limite de uso por minuto.
- **Privacidade:** mando pra IA só **números totais** (vendas, saldos, gado, cheques) — sem nome de cliente nem nada pessoal. E o Groq não treina com seus dados.
- **Perguntas:** a IA lê e responde ("quanto vendi hoje?", "qual o saldo dos bancos?", "tenho cheque pra compensar?").
- **Lançamentos:** você também pode pedir pra ela **lançar entrada ou saída** (ex.: "lança saída de 200 conta de luz"). Ela monta a proposta e você **confirma** antes de gravar. Tudo fica no log.

## Se der erro
- **"Falta configurar o segredo GROQ_API_KEY"** → você pulou o passo 3.
- **Erro 401 / não autorizado** → me avisa. Dá pra desligar a verificação de login da função (como o Groq é grátis, não tem risco de custo) num clique no painel, que eu te falo onde.
- **"confere se a função filezao-ia está no ar"** → o nome da função tem que ser exatamente `filezao-ia` e estar com Deploy feito.
