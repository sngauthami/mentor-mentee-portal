-- Run this once in Supabase -> SQL Editor
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text not null,
  role text not null check (role in ('mentee','mentor','hod')),
  mentor_id uuid references profiles(id),
  created_at timestamptz default now()
);
create table marks (
  id bigint generated always as identity primary key,
  mentee_id uuid not null references profiles(id) on delete cascade,
  subject text not null,
  marks int not null check (marks between 0 and 100),
  created_at timestamptz default now()
);
create table notes (
  id bigint generated always as identity primary key,
  mentee_id uuid not null references profiles(id) on delete cascade,
  mentor_id uuid not null references profiles(id),
  note text not null,
  seen boolean default false,
  created_at timestamptz default now()
);

create function my_role() returns text language sql security definer stable as
$$ select role from profiles where id = auth.uid() $$;

alter table profiles enable row level security;
alter table marks enable row level security;
alter table notes enable row level security;

create policy "profiles read" on profiles for select to authenticated using (true);
create policy "profiles insert own" on profiles for insert to authenticated with check (id = auth.uid());
create policy "profiles update own" on profiles for update to authenticated using (id = auth.uid());

create policy "marks read" on marks for select to authenticated using (mentee_id = auth.uid() or my_role() in ('mentor','hod'));
create policy "marks insert own" on marks for insert to authenticated with check (mentee_id = auth.uid());

create policy "notes read" on notes for select to authenticated using (mentee_id = auth.uid() or mentor_id = auth.uid() or my_role() = 'hod');
create policy "notes insert mentor" on notes for insert to authenticated with check (mentor_id = auth.uid() and my_role() = 'mentor');
create policy "notes mark seen" on notes for update to authenticated using (mentee_id = auth.uid());
