create table ACTOR(act_id integer primary key, act_name varchar(10), act_gender varchar(1));

create table DIRECTOR(dir_id integer primary key, dir_name varchar(20), dir_phone bigint);

create table MOVIES(mov_id integer primary key, mov_title varchar(20), mov_year integer,
mov_lang varchar(10), dir_id integer, foreign key(dir_id) references DIRECTOR(dir_id) on delete
cascade);

create table MOVIE_CAST(act_id integer, foreign key(act_id) references ACTOR(act_id) on delete
cascade, mov_id integer, foreign key(mov_id) references MOVIES(mov_id) on delete cascade, role
varchar(10), primary key(act_id,mov_id));

create table RATING(mov_id integer, foreign key(mov_id) references MOVIES(mov_id) on delete
cascade, rev_stars integer, primary key(mov_id,rev_stars));

INSERT INTO ACTOR VALUES (301,'ANUSHKA','F');

INSERT INTO ACTOR VALUES (302,'PRABHAS','M');

INSERT INTO ACTOR VALUES (303,'PUNITH','M');

INSERT INTO ACTOR VALUES (304,'JERMY','M');

INSERT INTO DIRECTOR VALUES (60,'RAJAMOULI', 8751611001);

INSERT INTO DIRECTOR VALUES (61,'HITCHCOCK', 7766138911);

INSERT INTO DIRECTOR VALUES (62,'FARAN', 9986776531);

INSERT INTO DIRECTOR VALUES (63,'STEVEN SPIELBERG', 8989776530);

INSERT INTO MOVIES VALUES (1001,'BAHUBALI-2', 2017, 'TELAGU', 60);

INSERT INTO MOVIES VALUES (1002,'BAHUBALI-1', 2015, 'TELAGU', 60);

INSERT INTO MOVIES VALUES (1003,'AKASH', 2008, 'KANNADA', 61);

INSERT INTO MOVIES VALUES (1004,'WAR HORSE', 2011, 'ENGLISH', 63);

INSERT INTO MOVIE_CAST VALUES (301, 1002, 'HEROINE');

INSERT INTO MOVIE_CAST VALUES (301, 1001, 'HEROINE');

INSERT INTO MOVIE_CAST VALUES (303, 1003, 'HERO');

INSERT INTO MOVIE_CAST VALUES (303, 1002, 'GUEST');

INSERT INTO MOVIE_CAST VALUES (304, 1004, 'HERO');

INSERT INTO RATING VALUES (1001, 4);

INSERT INTO RATING VALUES (1002, 2);

INSERT INTO RATING VALUES (1003, 5);

INSERT INTO RATING VALUES (1004, 4);

-- Queries:
select mov_title from MOVIES where dir_id IN (select dir_id from DIRECTOR where dir_name =
'HITCHCOCK');

select mov_title from MOVIES M , MOVIE_CAST MC where M.mov_id = MC.mov_id AND
MC.act_id IN (select act_id from MOVIE_CAST group by act_id having count(act_id)>1);

select act_name, mov_title, mov_year from ACTOR A JOIN movie_cast C on A.act_id = C.act_id
JOIN MOVIES M ON C.mov_id = M.mov_id where M.mov_year NOT BETWEEN 2000 and 2015;

select mov_title, max(rev_stars) from MOVIES INNER JOIN RATING using (mov_id) group by
mov_title having MAX(rev_stars) > 0 order by mov_title;

update RATING set rev_stars = 5 where mov_id IN (select mov_id from MOVIES where dir_id IN
(select dir_id from DIRECTOR where dir_name = 'STEVEN SPIELBERG'));
SELECT * FROM RATING;
