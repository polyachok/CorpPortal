insert into usr
    (id, activation_code, active, email, password, username)
    values (1, null, true, 'upolyakov@sdp-mo.ru', '123', 'admin');

insert into user_role
    (user_id, roles)
    VALUES (1, 'ADMIN'), (1, 'USER');