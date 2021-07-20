alter table company add author int8;

create table company_file (
                         id int8 not null,
                         name varchar(2048),
                         datecreate varchar(255),
                         author int8,
                         path varchar(2048),
                         company int8,
                         primary key (id)
);
