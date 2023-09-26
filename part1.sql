-------------------
-- Create tables --
-------------------

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
    Transaction_Store_ID bigint primary key not null,
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
        references Cards (Customer_Card_ID),
    foreign key (Transaction_Store_ID)
        references Stores (Transaction_Store_ID)
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


--------------
-- Triggers --
--------------
-> For Persons:
    1. Customer_Name and Customer_Surname:
        - Cyrillic or Latin
        - the first letter is capitalized
        - the rest are lower case
        - dashes and spaces are allowed
    2. Customer_Primary_Email
        - E-mail format
    3. Customer_Primary_Phone
        - +7 and 10 Arabic numerals

-> For SKU:
    1. SKU_Name
        - Cyrillic or Latin, Arabic numerals, special characters

-> For Groups_SKU:
    1. Group_Name
        - Cyrillic or Latin, Arabic numerals, special characters


----------------------
-- Want to remember --
----------------------
1. differences between procedures and functions
2. how to structure work with csv/tsv scripts
3. all about triggers


---------------
-- Materials --
---------------
-> To/from SCV/TSV:
    - https://www.sqlservercentral.com/articles/postgresql-table-import-export-from-and-to-csv-file
    - https://www.postgresqltutorial.com/postgresql-tutorial/export-postgresql-table-to-csv-file/
    - https://clickhouse.com/docs/en/integrations/data-formats/csv-tsv
