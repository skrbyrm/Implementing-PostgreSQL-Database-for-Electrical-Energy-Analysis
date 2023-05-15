-- Table Triggers

create trigger trigger_data_insert after
insert
    on
    public.consumptions for each row execute function trigger_cons_data();