'1.	List the names of customers who spent more than 450.00 on a single bill on occasions when ‘Charles’ was their Headwaiter.'
SELECT DISTINCT b.cust_name
FROM restBill b
JOIN restRoom_management rm ON b.bill_date = rm.room_date
JOIN restStaff s ON rm.headwaiter = s.staff_no
WHERE s.first_name = 'Charles' AND b.bill_total > 450.00;

'2.	A customer called Nerida has complained that a waiter was rude to her when she dined at the restaurant on the 11th January 2016. What is the name and surname of the Headwaiter who will have to deal with the matter?'
SELECT s.first_name, s.surname
FROM restRoom_management rm
JOIN restStaff s ON rm.headwaiter = s.staff_no
WHERE rm.room_date = 160111 AND EXISTS (
    SELECT 1
    FROM restBill b
    WHERE b.bill_date = 160111 AND b.cust_name = 'Nerida Smith'
);

'3.	What are the names of customers with the smallest bill?'
SELECT cust_name
FROM restBill
WHERE bill_total = (SELECT MIN(bill_total) FROM restBill);

'4.	List the names of any waiters who have not taken any bills.'
SELECT s.first_name, s.surname
FROM restStaff s
WHERE s.staff_no NOT IN (SELECT DISTINCT waiter_no FROM restBill);


'5.	Which customers had the largest single bill? List the customer name, the name and surname of headwaiters, and the room name where they were served on that occasion.'
SELECT b.cust_name, hs.first_name AS Headwaiter_First_Name, hs.surname AS Headwaiter_Surname, t.room_name
FROM restBill b
JOIN restRest_table t ON b.table_no = t.table_no
JOIN restRoom_management rm ON t.room_name = rm.room_name AND b.bill_date = rm.room_date
JOIN restStaff hs ON rm.headwaiter = hs.staff_no
WHERE b.bill_total = (SELECT MAX(bill_total) FROM restBill);
