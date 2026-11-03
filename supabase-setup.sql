-- Supabase SQL Editor-এ একবার চালান
create table if not exists public.tournament_state (
  id bigint primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.tournament_state enable row level security;

-- সবাই টুর্নামেন্টের তথ্য দেখতে পারবে
create policy "Public can read tournament" on public.tournament_state
for select using (true);

-- লগইন করা অ্যাডমিন তথ্য পরিবর্তন করতে পারবে
create policy "Authenticated admins can insert" on public.tournament_state
for insert to authenticated with check (true);

create policy "Authenticated admins can update" on public.tournament_state
for update to authenticated using (true) with check (true);

-- Supabase Dashboard > Authentication > Users থেকে নিজে অ্যাডমিন ইউজার তৈরি করুন।
-- গুরুত্বপূর্ণ: public signup বন্ধ রাখুন; কেবল Dashboard থেকে অ্যাডমিন ইউজার তৈরি করবেন।
