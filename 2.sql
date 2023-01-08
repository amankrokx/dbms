create table SALESMAN (Salesman_id integer primary key, Name varchar(20), City varchar(20),
Commission varchar(4));

create table CUSTOMER1 (Customer_id integer primary key, Cust_Name varchar(20), City
varchar(20), Grade integer, Salesman_id integer, foreign key(Salesman_id) references
SALESMAN(salesman_id) on delete cascade);

create table ORDERS (Ord_No integer primary key, Purchase_Amt integer, Ord_Date date,
Customer_id integer, foreign key(Customer_id) references CUSTOMER1(customer_id) on delete
cascade, Salesman_id integer, foreign key(Salesman_id) references SALESMAN(salesman_id) on
delete cascade);

INSERT INTO SALESMAN VALUES (1000, 'JOHN','BANGALORE','25 %');

INSERT INTO SALESMAN VALUES (2000, 'RAVI','BANGALORE','20 %');

INSERT INTO SALESMAN VALUES (3000, 'KUMAR','MYSORE','15 %');

INSERT INTO SALESMAN VALUES (4000, 'SMITH','DELHI','30 %');

INSERT INTO SALESMAN VALUES (5000, 'HARSHA','HYDERABAD','15 %');

INSERT INTO CUSTOMER1 VALUES (10, 'PREETHI','BANGALORE', 100, 1000);

INSERT INTO CUSTOMER1 VALUES (11, 'VIVEK','MANGALORE', 300, 1000);

INSERT INTO CUSTOMER1 VALUES (12, 'BHASKAR','CHENNAI', 400, 2000);

INSERT INTO CUSTOMER1 VALUES (13, 'CHETHAN','BANGALORE', 200, 2000);

INSERT INTO CUSTOMER1 VALUES (14, 'MAMATHA','BANGALORE', 400, 3000);

INSERT INTO ORDERS VALUES (50, 5000, '2017-05-04', 10, 1000);

INSERT INTO ORDERS VALUES (51, 450, '2017-01-20', 10, 2000);

INSERT INTO ORDERS VALUES (52, 1000, '2017-02-24', 13, 2000);

INSERT INTO ORDERS VALUES (53, 3500, '2017-04-13', 14, 3000);

INSERT INTO ORDERS VALUES (54, 550, '2017-03-09', 12, 2000);

-- Queries:
select grade , count(customer_id) from CUSTOMER1 group by grade having grade > (select
avg(grade) from CUSTOMER1 where city = 'BANGALORE');

select s.salesman_id, s.name from SALESMAN s where salesman_id IN (select salesman_id from
CUSTOMER1 c1 group by c1.salesman_id having count(*)>1);

select s.salesman_id, s.name, c.cust_name from SALESMAN s, CUSTOMER1 c where s.city = c.city
and s.salesman_id = c.salesman_id UNION select s.salesman_id, s.name , c.cust_name from
SALESMAN s, CUSTOMER1 c where s.city!=c.city and s.salesman_id = c.salesman_id;

create view ess_salesman as select b.ord_date, s.salesman_id, s.name from ORDERS b, SALESMAN s where s.salesman_id = b.salesman_id AND b.purchase_amt = (select MAX(purchase_amt) from
ORDERS c where c.ord_date = b.ord_date);
Select * from ess_salesman;

delete from SALESMAN where salesman_id = 1000;
select * from SALESMAN;

