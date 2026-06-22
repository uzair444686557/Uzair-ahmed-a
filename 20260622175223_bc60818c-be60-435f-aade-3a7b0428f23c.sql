
grant execute on function public.has_role(uuid, public.app_role) to authenticated;

create policy "no client access to request log" on public.request_log
  for select using (false);
