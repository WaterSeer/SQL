CREATE DATABASE pipes;
GO
USE pipes;

CREATE TABLE location_dict
(
    id INT PRIMARY KEY,   
    location_name NVARCHAR(200)    
);
CREATE TABLE unit_dict
(
    unit_id INT NOT NULL PRIMARY KEY,
    location_id  INT FOREIGN KEY REFERENCES location_dict(id) ON DELETE CASCADE,
    parent_id INT FOREIGN KEY REFERENCES unit_dict(unit_id),
    unit_name NVARCHAR(200),
    parametr_count INT
);





INSERT INTO location_dict
VALUES
	(1, 'Участок 1'),
    (2, 'Участок 2'),
    (3, 'Участок 3')

INSERT INTO unit_dict
VALUES
    (1, 1, null, 'ТЭСЦ', 100),
    (2, 2, null, 'ЦПиОП', 1000),
    (3, 1, 1, 'ТФУ', 10),
    (4, 1, 1, 'ВСС', 2000),
    (5, 1, 1, 'НСС', 1100), 
    (6, 2, 2, 'ОНП', 100),  
    (7, 2, 2, 'ОВП', 50),
    (8, 1, 3, 'КГП', 10),
    (9, 1, 3, 'КФУ', 10),
    (10, 1, 4, 'ВСС1', 135),
    (11, 1, 4, 'ВСС2', 135),
    (12, 1, 4, 'ВСС3', 140),
    (13, 1, 5, 'НСС1', 160),
    (14, 1, 5, 'НСС2', 160),
    (15, 1, 5, 'НСС3', 160),
    (16, 2, 6, 'Экструдер', 12),
    (17, 2, 7, 'Покраска', 28),
    (18, 2, 7, 'Мойка', 5),
    (19, 2, 7, 'Покраска', 5)


CREATE TABLE pipes
(
    matid INT PRIMARY KEY,
    pipe_no NVARCHAR(200)
);
CREATE TABLE unit_passes
(
    pass_id INT PRIMARY KEY,
    matid INT FOREIGN KEY REFERENCES pipes(matid),
    parent_pass_id INT FOREIGN KEY REFERENCES unit_passes(pass_id),
    unitid INT,
    dt DATE,
    duration INT
);
INSERT INTO pipes
VALUES
    (123456, 'Итз125704.9'),
    (123455, '125703.7_итз')

INSERT INTO unit_passes
VALUES
    (1, 123456, null, 1,    ('01.04.2016'), 10),
    (2, 123456, 1, 2,       ('01.04.2016'), 20),
    (3, 123455, null, 1,    ('01.05.2016'), 30),
    (4, 123456, 2, 5,       ('01.05.2016'), 40),
    (5, 123456, 4, 5,       ('02.05.2016'), 40),
    (6, 123456, 5, 11,      ('03.05.2016'), 40),
    (7, 123455, 3, 22,      ('04.05.2016'), 30),
    (8, 123455, 7, 22,      ('05.05.2016'), 60),
    (9, 123456, 6, 2,       ('06.05.2016'), 10),
    (10, 123456, 9, 805,    ('07.05.2016'), 10),
    (11, 123455, 8, 5,      ('07.05.2016'), 10),
    (12, 123456, 10, 1,     ('08.05.2016'), 10),
    (13, 123455, 11, 7,     ('09.05.2016'), 10),
    (14, 123456, 12, 7,     ('12.05.2016'), 10),
    (15, 123456, 14, 11,    ('14.05.2016'), 100),
    (16, 123455, 13, 3,     ('16.05.2016'), 20),
    (17, 123455, 16, 21,    ('18.05.2016'), 50),
    (18, 123455, 17, 23,    ('20.05.2016'), 60),
    (19, 123456, 15, 103,   ('21.05.2016'), 60),
    (20, 123456, 19, 104,   ('22.05.2016'), 60)





