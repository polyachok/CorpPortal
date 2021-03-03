alter table task add parentA int8 default 0;

alter table task add type int8 default 0;

create table agreement
    (
        id          int8         not null,
        name        varchar(255) not null,
        datecreate  varchar(255),
        dateclose   varchar(255),
        deadline    varchar(255),
        dead_line_status boolean default true,
        description text,
        author      int8         not null,
        status      varchar(255),
        path        text,
        route       int8,
        primary key (id)

);


