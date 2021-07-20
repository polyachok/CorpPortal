create table contract (
                        id int8 not null,
                        name varchar(254),
                        description varchar(254),
                        number varchar(32),
                        date varchar(32),
                        date_start varchar(32),
                        date_end varchar(32),
                        company1 int8,
                        company2 int8,
                        type integer,
                        author int8 not null,
                        date_create varchar(32),
                        status integer default 1,
                        primary key (id)
);



