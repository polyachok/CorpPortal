create table ag_comment (
                          id int8 not null,
                          datecreate varchar(255),
                          description text,
                          author int8 not null,
                          parent int8,
                          primary key (id)
);


create table agreement_comment
(
    agreement int8 not null ,
    comment int8 not null ,
    primary key (comment, agreement)
);