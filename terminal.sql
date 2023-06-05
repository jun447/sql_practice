select  * from branch;
select * from propertyforrent;
select * from registration;
select * from privateowner;
select * from staff;
select * from client;
select * from viewing;
# Question 1
SELECT b.branchNo, b.street, b.city, b.postcode
FROM branch b
         LEFT JOIN registration r ON b.branchNo = r.branchNo
WHERE r.branchNo IS NULL;
# Question 2 : Detail of brach with minimum staff
SELECT b.branchNo, b.street, b.city, b.postcode, COUNT(s.staffNo) AS staffCount
FROM branch b
         LEFT JOIN staff s ON b.branchNo = s.branchNo
GROUP BY b.branchNo
HAVING COUNT(s.staffNo) = (
    SELECT COUNT(staffNo)
    FROM staff
    GROUP BY branchNo
    ORDER BY COUNT(staffNo) ASC
    LIMIT 1
);
#  Question 3: write a query to findout who will retire first(if we consider 60 year for age retirement)
SELECT staffNo, fname, lName,DOB,
       DATEDIFF(CURDATE(), DOB) / 365 AS age from staff
where
        DATEDIFF(CURDATE(), DOB) / 365 > 60;

# Question 4: Generate a report that shows how many properties are registered in each branch
SELECT b.branchNo, b.street, b.city, b.postcode, COUNT(r.propertyNo) AS propertyCount
FROM branch b
         LEFT JOIN propertyforrent r ON b.branchNo = r.branchNo
GROUP BY b.branchNo
ORDER BY COUNT(r.propertyNo) DESC;
# Question 5: Generate a report that shows how many properties are of "Flat" type in each branch
SELECT b.branchNo, b.street, b.city, b.postcode, COUNT(r.propertyNo) AS propertyCount
FROM branch b
         LEFT JOIN propertyforrent r ON b.branchNo = r.branchNo
WHERE r.type = 'Flat'
GROUP BY b.branchNo
ORDER BY COUNT(r.propertyNo) DESC;
# Question 6: show how many private owners are from glasgow city
SELECT COUNT(r.ownerNo) AS ownerCount
FROM  propertyforrent r
         LEFT JOIN privateowner b ON r.ownerNo = b.ownerNo
WHERE r.city = 'Glasgow';
# question 7: write storeprocedure that receive branchNo and generate a report of employees working in that branch and branchNo is varchar
DELIMITER $$
CREATE PROCEDURE `staffByBranchNo`(IN branchNo VARCHAR(255))
BEGIN
    SELECT s.staffNo, s.fname, s.lName, s.DOB, s.position, s.salary, s.branchNo
    FROM staff s
    WHERE s.branchNo = branchNo;
END$$
DELIMITER ;
# call procedure
CALL staffByBranchNo('B007');
# Question 10:which city has more than one branch
SELECT b.city, COUNT(b.branchNo) AS branchCount
FROM branch b
GROUP BY b.city
HAVING COUNT(b.branchNo) > 1;
# Question 9:Detail of clients whose email address is at gmail.com and their preference is house and they are registered by staff members SG37
SELECT r.clientNo, r.fname, r.lName, r.email, r.prefType,r.eMail
FROM client r
         LEFT JOIN registration s ON r.clientNo = s.clientNo
WHERE r.eMail LIKE '%@gmail.com%' AND r.prefType = 'House' AND s.staffNo = 'SG37';
# Question 8: write an store procedure that receive clientNo and his her email and generate a report of properties that he she viewed till date use join between client and viewing
DELIMITER $$
CREATE PROCEDURE `viewedProperties`(IN clientNo VARCHAR(255), IN email VARCHAR(255))
BEGIN
    SELECT p.clientNo, p.lName, p.fname, p.email, p.prefType, v.propertyNo, v.viewDate,v.comment
    FROM client p
             LEFT JOIN viewing v ON p.clientNo = v.clientNo
    WHERE v.clientNo = clientNo AND p.eMail = email;
END$$
DELIMITER ;
# call procedure
CALL viewedProperties('CR56', 'astewart@hotmail.com');