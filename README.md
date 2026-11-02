# CRM Habita — versão privada para GitHub Pages

Esta versão usa login por e-mail e senha no Supabase e sincroniza os cadastros em uma tabela protegida por Row Level Security (RLS). O CRM é o mesmo em todos os aparelhos quando você entra com a mesma conta.

## 1. Configure o banco e o login

1. Crie um projeto no Supabase.
2. Abra SQL Editor, cole o conteúdo de supabase-setup.sql e execute.
3. Em Authentication → Sign In / Providers, mantenha Email habilitado e desative novos cadastros públicos.
4. Em Authentication → Users, crie sua conta com seu e-mail e senha. Use essa mesma conta em todos os aparelhos.
5. Em Project Settings → API Keys (ou API), copie a Project URL completa (https://...supabase.co) e a publishable key (prefixo sb_publishable_) para config.js. Não cole a região do projeto no campo da chave.

A chave publicável fica visível no site por definição. A proteção dos clientes vem do login e das políticas RLS do SQL. Nunca use a chave secreta service_role no navegador ou no GitHub. O Supabase recomenda RLS nas tabelas expostas e autorização por auth.uid().

## 2. Preserve os dados do CRM atual

Antes de trocar para esta versão, abra o CRM atual e vá em Configurações → Backup e transferência → Exportar backup JSON. Guarde o arquivo em local protegido.

Depois de publicar esta versão, entre com sua conta e use Configurações → Importar backup. A importação substitui os dados da nuvem, então faça isso somente na primeira migração e mantenha uma cópia do JSON.

## 3. Publique pelo GitHub Pages

1. Preencha config.js com a URL e a chave publicável do Supabase.
2. Envie os arquivos desta pasta (index.html, config.js e supabase-setup.sql) para um repositório GitHub. Não envie backups de clientes.
3. No repositório, abra Settings → Pages, escolha publicar pela branch principal e pela pasta raiz.
4. Abra o endereço publicado. Entre com o e-mail e a senha criados no Supabase.
5. Para usar no celular ou outro computador, abra o mesmo endereço e entre com a mesma conta.

O GitHub Pages hospeda arquivos estáticos; o banco e o login são fornecidos pelo Supabase. Mesmo que o repositório seja público, não há dados de clientes nos arquivos do site: cada conta só pode ler ou alterar sua própria linha no banco.

## Acesso e limites

- A tela não tem cadastro aberto. Crie usuários manualmente no painel do Supabase.
- Com uma conta, seus aparelhos compartilham a mesma carteira. Contas diferentes têm carteiras separadas; acesso compartilhado em equipe exigiria políticas de equipe específicas.
- É necessário internet para carregar e sincronizar os dados.
- O CRM continua oferecendo exportação e importação de backups JSON. Proteja os arquivos exportados.
- Evite editar o mesmo cadastro simultaneamente em dois aparelhos; a sincronização grava a carteira inteira por usuário.

## Arquivos

- index.html: CRM com login e sincronização protegida.
- config.js: URL do Supabase e chave publicável (preencher antes da publicação).
- supabase-setup.sql: tabela, permissões e políticas de acesso por usuário.
