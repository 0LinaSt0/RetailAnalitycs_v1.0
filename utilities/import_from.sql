drop procedure import_from;
create or replace procedure import_from(tablename varchar, filepath varchar) as
$$
begin
    execute format('copy %s from ''%s'' delimiter E''\t'';', tablename, filepath);
exception
    when others then raise;
end;
$$ language plpgsql;

do
$$
declare
    datasets_dir varchar := '/Users/pmaryjo/Desktop/RetailAnalitycs_v1.0/datasets/';
begin
    call import_from('Persons', concat(datasets_dir, 'Personal_Data_Mini.tsv'));
    call import_from('Cards', concat(datasets_dir, 'Cards_Mini.tsv'));
    call import_from('Groups_SKU', concat(datasets_dir, 'Groups_SKU_Mini.tsv'));
    call import_from('SKU', concat(datasets_dir, 'SKU_Mini.tsv'));
    call import_from('Stores', concat(datasets_dir, 'Stores_Mini.tsv'));
    call import_from('Transactions', concat(datasets_dir, 'Transactions_Mini.tsv'));
    call import_from('Checks', concat(datasets_dir, 'Checks_Mini.tsv'));
    call import_from('Date_Of_Analysis_Formation', concat(datasets_dir, 'Date_Of_Analysis_Formation.tsv'));
end;
$$ language plpgsql;
