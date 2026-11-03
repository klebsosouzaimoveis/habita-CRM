# Instalação da ficha no habita-CRM

O CRM já existe. Este pacote acrescenta a ficha em uma subpasta para não trocar a tela inicial do CRM.

## Faça nesta ordem

1. **Descompacte o ZIP.**
2. **No repositório GitHub do CRM**, acrescente as pastas `ficha` e `supabase` do pacote. Mantenha os arquivos que já existem na raiz, principalmente o `index.html` do CRM. Se o repositório já tiver `supabase/config.toml`, mantenha-o e copie a configuração da função do pacote para ele.
3. **No Supabase do CRM**, abra **SQL Editor → New query** e execute `supabase/pre_venda_cadastros.sql`.
4. **Crie um widget no Cloudflare Turnstile** para `klebsosouzaimoveis.github.io`. Guarde a site key e a secret key.
5. **Crie a função de recebimento no Supabase:** abra **Edge Functions → Deploy a new function → Via Editor**, dê o nome `receber-ficha` e cole o conteúdo de `supabase/functions/receber-ficha/index.ts`. Publique. Depois abra os detalhes da função e desligue **Verify JWT**. A função tem sua própria verificação antirobô. O Supabase permite criar e publicar funções pelo painel; a verificação JWT pode ser desligada nos detalhes da função.
6. **Cadastre os segredos da função** nas configurações de Edge Function Secrets do projeto:
   - `ADMIN_USER_ID`: UUID da sua conta no Supabase Auth
   - `ALLOWED_ORIGIN`: `https://klebsosouzaimoveis.github.io`
   - `TURNSTILE_SECRET_KEY`: secret key do Turnstile
   - `TURNSTILE_HOSTNAME`: `klebsosouzaimoveis.github.io`
7. **Preencha as configurações públicas nos arquivos:**
   - Em `ficha/index.html`: `EDGE_FUNCTION_URL`, `TURNSTILE_SITE_KEY` e `SUPABASE_PUBLISHABLE_KEY`.
   - Em `ficha/admin.html`: `SUPABASE_URL` e `SUPABASE_ANON_KEY` (ou publishable key).
   - URL da função: `https://SEU_PROJECT_REF.supabase.co/functions/v1/receber-ficha`.
8. **Salve as alterações no GitHub** (commit). O Pages publicará a ficha em `https://klebsosouzaimoveis.github.io/habita-CRM/ficha/`; sua área restrita ficará em `https://klebsosouzaimoveis.github.io/habita-CRM/ficha/admin.html`.
9. **Teste com dados fictícios.** Preencha a ficha e confirme o envio; depois entre na área restrita com sua conta do CRM e confira o registro.

Quem preenche não cria conta. O login é só para você consultar as fichas. Se o envio falhar, a ficha avisa e oferece gerar o PDF sem enviar os dados.

**Importante:** `SUPABASE_PUBLISHABLE_KEY`/`SUPABASE_ANON_KEY` pode ficar na página pública por ser uma chave pública. Nunca coloque `service_role`, `secret key` do Supabase ou `TURNSTILE_SECRET_KEY` no HTML ou no GitHub.
