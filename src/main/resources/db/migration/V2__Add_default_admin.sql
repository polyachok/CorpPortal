insert into usr
(id, activation_code, active, email, password, username, departament, position, status, firstname, surname, patronomic, mphone, wphone)
values (1, null, true, 'upolyakov@sdp-mo.ru', crypt('123', gen_salt('bf' , 8)), 'admin', null, null, null, 'super', 'user', null, null, null);

insert into user_role
(user_id, roles)
VALUES (1, 'ADMIN'), (1, 'USER');
