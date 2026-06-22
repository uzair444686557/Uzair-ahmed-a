
-- Role enum + user_roles + has_role
create type public.app_role as enum ('admin');

create table public.user_roles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  role app_role not null,
  created_at timestamptz not null default now(),
  unique(user_id, role)
);

grant select on public.user_roles to authenticated;
grant all on public.user_roles to service_role;
alter table public.user_roles enable row level security;

create policy "users can view their own roles" on public.user_roles
  for select to authenticated using (user_id = auth.uid());

create or replace function public.has_role(_user_id uuid, _role app_role)
returns boolean
language sql stable security definer set search_path = public
as $$
  select exists (
    select 1 from public.user_roles
    where user_id = _user_id and role = _role
  )
$$;

-- Watches
create table public.watches (
  id uuid primary key default gen_random_uuid(),
  brand text not null,
  model text not null,
  reference_number text,
  year int,
  case_size_mm int,
  movement_type text,
  condition text not null check (condition in ('Mint','Excellent','Good')),
  price numeric(12,2) not null,
  currency text not null default 'USD',
  images text[] not null default '{}',
  description text,
  is_sold boolean not null default false,
  is_featured boolean not null default false,
  created_at timestamptz not null default now()
);

grant select on public.watches to anon, authenticated;
grant insert, update, delete on public.watches to authenticated;
grant all on public.watches to service_role;

alter table public.watches enable row level security;

create policy "anyone can read watches" on public.watches
  for select using (true);
create policy "admins can insert watches" on public.watches
  for insert to authenticated with check (public.has_role(auth.uid(),'admin'));
create policy "admins can update watches" on public.watches
  for update to authenticated using (public.has_role(auth.uid(),'admin'));
create policy "admins can delete watches" on public.watches
  for delete to authenticated using (public.has_role(auth.uid(),'admin'));

create index watches_brand_idx on public.watches(brand);
create index watches_featured_idx on public.watches(is_featured) where is_featured = true;

-- Inquiries (contact form submissions)
create table public.inquiries (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  message text not null,
  watch_interested_in text,
  created_at timestamptz not null default now()
);

grant select, delete on public.inquiries to authenticated;
grant all on public.inquiries to service_role;
alter table public.inquiries enable row level security;

create policy "admins can read inquiries" on public.inquiries
  for select to authenticated using (public.has_role(auth.uid(),'admin'));
create policy "admins can delete inquiries" on public.inquiries
  for delete to authenticated using (public.has_role(auth.uid(),'admin'));

-- Newsletter subscribers
create table public.newsletter_subscribers (
  id uuid primary key default gen_random_uuid(),
  email text not null unique,
  created_at timestamptz not null default now()
);

grant select, delete on public.newsletter_subscribers to authenticated;
grant all on public.newsletter_subscribers to service_role;
alter table public.newsletter_subscribers enable row level security;

create policy "admins can read newsletter" on public.newsletter_subscribers
  for select to authenticated using (public.has_role(auth.uid(),'admin'));

-- Rate limit log (server-side ad-hoc limiter)
create table public.request_log (
  id bigserial primary key,
  ip_hash text not null,
  kind text not null,
  created_at timestamptz not null default now()
);
grant all on public.request_log to service_role;
alter table public.request_log enable row level security;
create index request_log_lookup_idx on public.request_log(ip_hash, kind, created_at);
