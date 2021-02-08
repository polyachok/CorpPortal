create sequence hibernate_sequence start 1 increment 1;

create table config (
    id int8 not null,
    configname varchar(255),
    param varchar(255),
    paramname varchar(255),
    primary key (id)
);

create table message (
    id int8 not null,
    filename varchar(255),
    tag varchar(255),
    text varchar(2048) not null,
    user_id int8,
    primary key (id)
);

create table user_role (
    user_id int8 not null,
    roles varchar(255)
);

create table departament (
    id int8 not null,
    name varchar(255)
);

create table position (
    id int8 not null,
    name varchar(255)
);

create table usr (
    id int8 not null,
    activation_code varchar(255),
    active boolean not null,
    email varchar(255),
    password varchar(255) not null,
    username varchar(255) not null,
    departament int8,
    position int8,
    status varchar(255),
    firstname varchar(255),
    surname varchar(255),
    patronomic varchar(255),
    mphone varchar(255),
    wphone varchar(255),
    avatar VARCHAR (255),
    primary key (id)
);

create table project (
     id int8 not null,
     name varchar(255) not null,
     datecreate varchar(255),
     dateclose varchar(255),
     description text,
     author int8 not null,
     status varchar(255),
     parent int8,
     primary key (id)
);

create table project_team
(
    project int8 not null ,
    team    int8 not null ,
    primary key (project, team)
);

alter table if exists message
    add constraint message_user_fk
    foreign key (user_id) references usr;

alter table if exists user_role
    add constraint user_role_user_fk
    foreign key (user_id) references usr;

create extension if not exists pgcrypto;

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
    comment int8 not null ,
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

create table task
(
    id          int8         not null,
    name        varchar(255) not null,
    datecreate  varchar(255),
    dateclose   varchar(255),
    deadline    varchar(255),
    dead_line_status boolean default true,
    description text,
    author      int8         not null,
    responsible int8         not null,
    status      varchar(255),
    parentP      int8,
    parentT      int8,
    primary key (id)

);

create table task_team
(
    task int8 not null ,
    team    int8 not null ,
    primary key (task, team)
);

create table tcomment (
                          id int8 not null,
                          datecreate varchar(255),
                          description text,
                          author int8 not null,
                          parent int8,
                          primary key (id)
);

create table task_comment (
                              task int8 not null ,
                              comment    int8 not null ,
                              primary key (comment, task)
);


create table ta_co_file (
                            id int8 not null,
                            name varchar(2048),
                            datecreate varchar(255),
                            author int8,
                            path varchar(2048),
                            parent int8,
                            primary key (id)
);

create table t_comment_file (
                                comment int8 not null ,
                                file    int8 not null ,
                                primary key (comment, file)
);