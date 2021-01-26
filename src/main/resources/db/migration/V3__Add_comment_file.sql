create table pcomment (
                      id int8 not null,
                      datecreate varchar(255),
                      description text,
                      author int8 not null,
                      parent int8,
                      primary key (id)
);


create table project_comment
(
    project int8 not null ,
    comment    int8 not null ,
    primary key (comment, project)
);

create table pr_co_file
(
        id int8 not null,
        name varchar(2048),
        datecreate varchar(255),
        author int8,
        path varchar(2048),
        parent int8,
        primary key (id)
);


create table pcomment_file
(
    comment int8 not null ,
    file    int8 not null ,
    primary key (comment, file)
);


