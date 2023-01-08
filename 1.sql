create table PUBLISHER (Name varchar(20) primary key,Phone bigint, Address varchar(20)) ;

create table BOOK (Book_id integer primary key, Title varchar(20), Pub_Year date, Publisher_Name
varchar(20),Foreign key(Publisher_Name) references Publisher(Name) on delete cascade);

create table BOOK_AUTHORS (Author_Name varchar(20), Book_id integer,foreign key(Book_id)
references Book(Book_id) on delete cascade, primary key(Book_id, Author_Name));

create table LIBRARY_BRANCH (Branch_id integer primary key, Branch_Name varchar(20), Address
varchar(20));

create table BOOK_COPIES (No_of_Copies integer, Book_id integer,foreign key(Book_id) references
Book(Book_id) on delete cascade, Branch_id integer,foreign key(Branch_id) references
Library_Branch(Branch_id) on delete cascade, Primary key(Book_id,Branch_id));

create table CARD(Card_no integer primary key);

create table BOOK_LENDING (DATE_OUT date, DUE_DATE date, BOOK_ID integer,foreign
key(book_id) references Book(Book_id) on delete cascade, Branch_id integer,foreign key(Branch_id)
references Library_Branch(Branch_id) on delete cascade, Card_no integer, foreign key(Card_no)
references Card(Card_no) on delete cascade, primary key(Book_id, Branch_id, card_no));

INSERT INTO PUBLISHER VALUES ('MCGRAW-HILL', 9989076587, 'BANGALORE');

INSERT INTO PUBLISHER VALUES ('PEARSON', 9889076565, 'NEWDELHI');

INSERT INTO PUBLISHER VALUES ('RANDOM HOUSE', 7455679345, 'HYDRABAD');

INSERT INTO PUBLISHER VALUES ('HACHETTE LIVRE', 8970862340, 'CHENAI');

INSERT INTO PUBLISHER VALUES ('GRUPO PLANETA', 7756120238, 'BANGALORE');

INSERT INTO BOOK VALUES (1,'DBMS','2017-01-01','MCGRAW-HILL');

INSERT INTO BOOK VALUES (2,'ADBMS','2016-06-22', 'MCGRAW-HILL');

INSERT INTO BOOK VALUES (3,'CN','2016-09-24', 'PEARSON');

INSERT INTO BOOK VALUES (4,'CG','2015-09-13', 'GRUPO PLANETA');

INSERT INTO BOOK VALUES (5,'OS','2016-05-09', 'PEARSON');

INSERT INTO BOOK_AUTHORS VALUES ('NAVATHE', 1);

INSERT INTO BOOK_AUTHORS VALUES ('NAVATHE', 2);

INSERT INTO BOOK_AUTHORS VALUES ('TANENBAUM', 3);

INSERT INTO BOOK_AUTHORS VALUES ('EDWARD ANGEL', 4);

INSERT INTO BOOK_AUTHORS VALUES ('GALVIN', 5);

INSERT INTO LIBRARY_BRANCH VALUES (10,'RR NAGAR','BANGALORE');

INSERT INTO LIBRARY_BRANCH VALUES (11,'RNSIT','BANGALORE');

INSERT INTO LIBRARY_BRANCH VALUES (12,'RAJAJI NAGAR', 'BANGALORE');

INSERT INTO LIBRARY_BRANCH VALUES (13,'NITTE','MANGALORE');

INSERT INTO LIBRARY_BRANCH VALUES (14,'MANIPAL','UDUPI');

INSERT INTO BOOK_COPIES VALUES (10, 1, 10);

INSERT INTO BOOK_COPIES VALUES (5, 1, 11);

INSERT INTO BOOK_COPIES VALUES (2, 2, 12);

INSERT INTO BOOK_COPIES VALUES (5, 2, 13);

INSERT INTO BOOK_COPIES VALUES (7, 3, 14);

INSERT INTO BOOK_COPIES VALUES (1, 5, 10);

INSERT INTO BOOK_COPIES VALUES (3, 4, 11);

INSERT INTO CARD VALUES (100);

INSERT INTO CARD VALUES (101);

INSERT INTO CARD VALUES (102);

INSERT INTO CARD VALUES (103);

INSERT INTO CARD VALUES (104);

INSERT INTO BOOK_LENDING VALUES ('2017-01-01','2017-06-01', 1, 10, 101);

INSERT INTO BOOK_LENDING VALUES ('2017-01-11','2017-03-11', 3, 14, 101);

INSERT INTO BOOK_LENDING VALUES ('2017-02-21','2017-04-21', 2, 13, 101);

INSERT INTO BOOK_LENDING VALUES ('2017-03-15','2017-07-15', 4, 11, 101);

INSERT INTO BOOK_LENDING VALUES ('2017-04-12','2017-05-12', 1, 11, 104);

-- Queries:
select B.book_id, B.title, B.publisher_name, A.author_name, C.no_of_copies, C.branch_id from
Book B, BOOK_AUTHORS A, BOOK_COPIES C, LIBRARY_BRANCH L where B.book_id = A.book_id and
B.book_id = C.book_id and L.branch_id = C.branch_id;

select card_no BOOK_LENDING where date_out between '201701-01' And '2017-07-01' Group by
card_no Having count(*) > 3;

delete from BOOK where book_id = 3;
 select * from BOOK;

create view v_pub as select distinct(pub_year) from BOOK;
 select * from v_pub;

create view V_books as select B.book_id, B.title, C.no_of_copies from BOOK B, BOOK_COPIES C,
LIBRARY_BRANCH L where B.book_id = C.book_id and C.branch_id = L.branch_id;
 select * from V_books;

