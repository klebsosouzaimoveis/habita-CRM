-- CRM Habita: uma carteira privada por conta autenticada.
-- Execute no SQL Editor do Supabase antes de publicar o site.

create table if not exists public.crm_private_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null check (jsonb_typeof(payload) = 'object'),
  updated_at timestamptz not null default now()
);

alter table public.crm_private_data enable row level security;
revoke all on table public.crm_private_data from public, anon, authenticated;
grant select, insert, update, delete on table public.crm_private_data to authenticated;

drop policy if exists "crm_owner_read" on public.crm_private_data;
drop policy if exists "crm_owner_insert" on public.crm_private_data;
drop policy if exists "crm_owner_update" on public.crm_private_data;
drop policy if exists "crm_owner_delete" on public.crm_private_data;

create policy "crm_owner_read"
  on public.crm_private_data for select to authenticated
  using ((select auth.uid()) = user_id);

create policy "crm_owner_insert"
  on public.crm_private_data for insert to authenticated
  with check ((select auth.uid()) = user_id);

create policy "crm_owner_update"
  on public.crm_private_data for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create policy "crm_owner_delete"
  on public.crm_private_data for delete to authenticated
  using ((select auth.uid()) = user_id);
