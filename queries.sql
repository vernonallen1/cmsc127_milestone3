DROP DATABASE PROJ;

CREATE DATABASE proj;

USE proj;

CREATE TABLE PERSON(
  userID VARCHAR(4) NOT NULL,
  fName VARCHAR(30),
  lName VARCHAR(30),
  moneyOwed DECIMAL(8, 2),
  moneyLent DECIMAL(8, 2),
  borrowerId_fk VARCHAR(4),
  PRIMARY KEY (userID),
  CONSTRAINT borrower_user FOREIGN KEY (borrowerId_fk) REFERENCES PERSON(userID)
);

CREATE TABLE GROUPING(
    groupID VARCHAR(4) NOT NULL,
    groupName VARCHAR (30),
    moneyOwed DECIMAL(8,2), 
    moneyLent DECIMAL(8,2),
    PRIMARY KEY (groupID)
);

CREATE TABLE GROUP_MEMBER (
    groupID VARCHAR(4) NOT NULL, 
    memberID VARCHAR(4) NOT NULL, 
    PRIMARY KEY(groupID, memberID)
);

CREATE TABLE EXPENSE(
    expenseID VARCHAR(6) NOT NULL,
    amount DECIMAL(8,2),
    sender VARCHAR(4),
    recipient VARCHAR(4),
    dateOwed DATE,
    datePaid DATE,
    userID VARCHAR(4),
    groupID VARCHAR(4),
    PRIMARY KEY(expenseID),
    CONSTRAINT deptfk FOREIGN KEY (userID) references PERSON(userID),
    CONSTRAINT groupfk FOREIGN KEY (groupID) references GROUPING(groupID)
);

INSERT INTO person VALUES("U1", "Mario", "Beatles", -100, 300, NULL);
INSERT INTO person VALUES("U2", "Lea", "Smith", -30, 130, "U1");
INSERT INTO person VALUES("U3", "Sophia", "Brown", -400, 500, "U1");
INSERT INTO person VALUES("U4", "Daniel", "Taft", -1500, 1500, "U1");
INSERT INTO person VALUES("U5", "Olivia", "Davis", 400, 0, "U1");

INSERT INTO GROUPING VALUES("G1", "AAA", 8000, 2000);
INSERT INTO GROUPING VALUES("G2", "BBB", 11000, 4000);

INSERT INTO group_member VALUES(1, 1);
INSERT INTO group_member VALUES(1, 2);
INSERT INTO group_member VALUES(2, 5);
INSERT INTO group_member VALUES(1, 3);
INSERT INTO group_member VALUES(2, 4);

INSERT INTO EXPENSE VALUES ("E1", 10000, "U3","U1", '2021-07-12', '2021-07-20', "U1",null);
INSERT INTO EXPENSE VALUES ("E2", 20000, "U5","U1" , '2022-01-12', '2022-09-26', "U1",null);
INSERT INTO EXPENSE VALUES ("E3", 1000, "U4", "U1", '2010-01-02', '2012-11-19', "U1", null);
INSERT INTO EXPENSE VALUES ("E4", 1050, "U5", "U1", '2021-07-20', NULL, "U1",null);
INSERT INTO EXPENSE VALUES ("E5", 120, "G2","U1", '2019-07-12', NULL, "U1","G2");
INSERT INTO EXPENSE VALUES ("E6", 150, "U1","G1", '2019-07-12', NULL, "U1","G1");
INSERT INTO EXPENSE VALUES ("E7", 150, "U1","G1", '2019-07-12', NULL, "U1","G1");
INSERT INTO EXPENSE VALUES ("E8", 150, "U1","G2", '2019-07-12', NULL, "U1","G2");

--TRANSACTION
UPDATE EXPENSE set amount = 0 WHERE expenseID = "E2";
SELECT * from EXPENSE where expenseID = "E2";
DELETE from EXPENSE where expenseID = "E2";

-- USER
UPDATE PERSON SET moneyOwed = 0 WHERE userID = "U2";
SELECT * from PERSON where userID = "U2";
delete from PERSON where userID = "U2";

-- GROUP
UPDATE GROUPING set moneyOwed = 0 where groupID = "G2";
SELECT * from GROUPING where groupID = "G2";
--DELETE FROM EXPENSE where groupID = "G2";
--DELETE from GROUPING where groupID = "G2";

-- GENERATE REPORTS
--view all expenses made within a month (eg JULY)
SELECT * from EXPENSE where sender="U3" and MONTH(dateOwed) = 7;

--view all expenses made with a friend (e.g userID of friend = 2
SELECT * from EXPENSE where sender="U1" and recipient ="U2";
SELECT * from EXPENSE where sender="U2" and recipient ="U1";

--view all expenses made with a group
SELECT * from EXPENSE where sender="U1" and groupID IS NOT NULL;
SELECT * from EXPENSE where recipient = "U1" and groupID IS NOT NULL;

--view current balance from all expenses
SELECT moneyOwed as Balance from PERSON group by userID having userID = "U1";

--view all friends with outstanding balance
SELECT * from PERSON where userid != "U1" AND moneyOwed > 0;

--view all groups
SELECT * from GROUPING;

--view all groups with an outstanding balance
SELECT * from GROUPING where moneyOwed > 0;


SELECT* FROM EXPENSE;
SELECT SUM(amount) from EXPENSE where sender = "U1" Group by groupID;
