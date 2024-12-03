'1)	Create a view with the name samsBills to allow the waiter Sam Pitt to see the bills he has taken. It should have columns in that order: first_name, surname, bill_date, cust_name, and bill_total.'
CREATE VIEW samsBills AS
SELECT 
    s.first_name, 
    s.surname, 
    b.bill_date, 
    b.cust_name, 
    b.bill_total
FROM restBill b
JOIN restStaff s ON b.waiter_no = s.staff_no
WHERE s.first_name = 'Sam' AND s.surname = 'Pitt';


'2)	Suppose Sam knows a bit of SQL. Write a query using the samsBills view so he can see only bills over £400.'
SELECT first_name, surname, bill_date, cust_name, bill_total
FROM samsBills
WHERE bill_total > 400.00;



'3)	Create a view with the name roomTotals to allow management to see how much each room has taken. The columns should be named: room_name and total_sum.'
CREATE VIEW roomTotals AS
SELECT 
    t.room_name, 
    SUM(b.bill_total) AS total_sum
FROM restBill b
JOIN restRest_table t ON b.table_no = t.table_no
GROUP BY t.room_name;



'4)	Create a view with the name teamTotals to allow management to see how much each team has taken. Please concatenate the first name and the surname of the waiter with the space in between. The columns should be named: headwaiter_name and total_sum.'
CREATE VIEW teamTotals AS
SELECT 
    CONCAT(h.first_name, ' ', h.surname) AS headwaiter_name, 
    SUM(b.bill_total) AS total_sum
FROM restBill b
JOIN restStaff w ON b.waiter_no = w.staff_no
JOIN restStaff h ON w.headwaiter = h.staff_no
GROUP BY h.first_name, h.surname;
