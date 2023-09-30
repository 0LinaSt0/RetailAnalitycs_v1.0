create table if not exists Persons (
    Customer_ID bigint primary key not null,
    Customer_Name varchar not null,
    Customer_Surname varchar not null,
    Customer_Primary_Email varchar unique not null,
    Customer_Primary_Phone varchar(12) not null
);

create table if not exists Cards (
    Customer_Card_ID bigint primary key not null,
    Customer_ID bigint not null,
    foreign key (Customer_ID)
        references Persons (Customer_ID)
);

create table if not exists Groups_SKU (
    Group_ID bigint primary key not null,
    Group_Name varchar not null
);

create table if not exists SKU (
    SKU_ID bigint primary key not null,
    SKU_NAME varchar not null,
    Group_ID bigint not null,
    foreign key (Group_ID)
        references Groups_SKU (Group_ID)
);

create table if not exists Stores (
    Transaction_Store_ID bigint not null,
    SKU_ID bigint not null,
    SKU_Purchase_Price float not null,
    SKU_Retail_Price float not null,
    foreign key (SKU_ID)
        references SKU (SKU_ID)
);

create table if not exists Transactions (
    Transaction_ID bigint primary key not null,
    Customer_Card_ID bigint not null,
    Transaction_Summ float not null,
    Transaction_DateTime timestamp not null,
    Transaction_Store_ID bigint not null,
    foreign key (Customer_Card_ID)
        references Cards (Customer_Card_ID)
);

create table if not exists Checks (
    Transaction_ID bigint references Transactions unique not null,
    SKU_ID bigint not null,
    SKU_Amount float not null,
    SKU_Summ float not null,
    SKU_Summ_Paid float not null,
    SKU_Summ_Discount float not null,
    foreign key (SKU_ID)
        references SKU (SKU_ID)
);

create table if not exists Date_Of_Analysis_Formation (
    Analysis_Formation timestamp not null
);

do
$$
declare
    str varchar := '23.08.2018 0:47:37';
    aaa timestamp := to_timestamp('23.08.2018 0:47:37', 'DD.MM.YYYY HH24:MI:SS');
begin
    raise notice 'time %', aaa;
end;
$$ language plpgsql;


--- Input date/time string to timestamp converter ---
create or replace function fnc_str_to_timestamp(str varchar) returns timestamp
as $$
begin
    return to_timestamp(str, 'DD.MM.YYYY HH24:MI:SS');
end;
$$ language plpgsql;

--- Triggers ---
create or replace function trg_fnc_transactions_before_insert() returns trigger as
$$
begin
    new.Transaction_DateTime = to_timestamp(new.Transaction_DateTime, 'DD.MM.YYYY HH24:MI:SS');
    return new;
end;
$$ language plpgsql;

drop trigger if exists trg_transactions_before_insert on Transactions;
create trigger trg_transactions_before_insert
before insert on Transactions
for each row
execute procedure trg_fnc_transactions_before_insert();

create or replace function trg_fnc_date_of_analysis_formation_before_insert() returns trigger as
$$
begin
    new.Analysis_Formation = to_timestamp(new.Analysis_Formation, 'DD.MM.YYYY HH24:MI:SS');
    return new;
end;
$$ language plpgsql;

drop trigger if exists trg_date_of_analysis_formation_before_insert on Date_Of_Analysis_Formation;
create trigger trg_date_of_analysis_formation_before_insert
before insert on Date_Of_Analysis_Formation
for each row
execute procedure trg_fnc_date_of_analysis_formation_before_insert();
