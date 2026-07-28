-- アプリ全体の設定（強制アップデート / メンテナンスモード）。1行だけ使う。
-- 値の変更はダッシュボードの Table Editor から行う。
create table public.app_config (
  id int primary key default 1 check (id = 1),
  min_build_number int not null default 0,
  maintenance_mode boolean not null default false,
  maintenance_message text
);

alter table public.app_config enable row level security;

-- 未ログイン含む全クライアントから読み取り可。書き込みポリシーは作らない
-- （service role またはダッシュボードからのみ変更する）
create policy "app_config is readable by everyone"
  on public.app_config for select
  using (true);

insert into public.app_config (id) values (1);
