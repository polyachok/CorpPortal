
create table route
(
    id  int8 not null,
    name varchar(255) not null,
    primary key (id)
);

create table sequence
(
    id int8 not null,
    number int8 not null,
    route int8 not null,
    usr int8 not null,
    primary key (id)
);

