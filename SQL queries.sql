#1.Display snum,sname,city and comm of all salespeople.
SELECT snum, sname, city, comm FROM SALESPEOPLE;


#2.Display all snum without duplicates from all orders.
SELECT DISTINCT snum
FROM ORDERS;


#3.Display names and commissions of all salespeople in london.
SELECT sname, comm
FROM SALESPEOPLE
WHERE city = 'London';


#4.All customers with rating of 100.
SELECT *
FROM CUST
WHERE rating = 100;


#5.Produce orderno, amount and date form all rows in the order table.
SELECT onum, amt, odate
FROM ORDERS;


#6.All customers in San Jose, who have rating more than 200.
SELECT *
FROM CUST
WHERE city = 'San Jose' AND rating > 200;


#7.All customers who were either located in San Jose or had a rating above 200.
SELECT * FROM CUST WHERE city = 'San Jose' OR rating > 200;


#8.All orders for more than $1000.
SELECT * FROM ORDERS WHERE amt > 1000;


#9.Names and citires of all salespeople in london with commission above 0.10.
SELECT sname, city FROM SALESPEOPLE WHERE city = 'London' AND comm > 0.10;


#10.All customers excluding those with rating <= 100 unless they are located in Rome.
SELECT * FROM CUST 
WHERE rating > 100 OR city = 'Rome';


#11.All salespeople either in Barcelona or in london.
SELECT * FROM SALESPEOPLE 
WHERE city IN ('Barcelona', 'London');


#12.All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
SELECT * FROM SALESPEOPLE 
WHERE comm > 0.10 AND comm < 0.12;


#13.All customers with NULL values in city column.
SELECT * FROM CUST WHERE city IS NULL;


#14.All orders taken on Oct 3Rd   and Oct 4th  1994.
SELECT * FROM ORDERS 
WHERE odate IN ('03-OCT-94', '04-OCT-94');


#15.All customers serviced by peel or Motika.
SELECT * FROM CUST 
WHERE snum IN (
  SELECT snum FROM SALESPEOPLE WHERE sname IN ('Peel', 'Motika')
);


#16.All customers whose names begin with a letter from A to B.
SELECT * FROM CUST 
WHERE cname BETWEEN 'A' AND 'Bz';


#17.All orders except those with 0 or NULL value in amt field.
SELECT * FROM ORDERS 
WHERE amt IS NOT NULL AND amt != 0;


#18.Count the number of salespeople currently listing orders in the order table.
SELECT COUNT(DISTINCT snum) FROM ORDERS;


#19.Largest order taken by each salesperson, datewise.
SELECT snum, odate, MAX(amt) AS max_amt
FROM ORDERS
GROUP BY snum, odate;


#20.Largest order taken by each salesperson with order value more than $3000.
SELECT snum, MAX(amt) AS max_amt
FROM ORDERS
WHERE amt > 3000
GROUP BY snum;


#21.Which day had the hightest total amount ordered.
SELECT odate, SUM(amt) AS total
FROM ORDERS
GROUP BY odate
ORDER BY total DESC
FETCH FIRST 1 ROW ONLY;


#22.Count all orders for Oct 3rd.
SELECT COUNT(*) FROM ORDERS WHERE odate = '03-OCT-94';


#23.Count the number of different non NULL city values in customers table.
SELECT COUNT(DISTINCT city) FROM CUST WHERE city IS NOT NULL;


#24.Select each customer’s smallest order.
SELECT cnum, MIN(amt) AS smallest_order
FROM ORDERS
GROUP BY cnum;


#25.First customer in alphabetical order whose name begins with G.
SELECT * FROM CUST 
WHERE cname LIKE 'G%' 
ORDER BY cname 
FETCH FIRST 1 ROW ONLY;


#26.Get the output like “ For dd/mm/yy there are ___ orders.
SELECT TO_CHAR(odate, 'DD/MM/YY') AS order_date,
       COUNT(*) || ' orders' AS order_count
FROM ORDERS
GROUP BY odate;


#27.Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
SELECT onum, snum, amt * 0.12 AS commission
FROM ORDERS;


#28.Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).
SELECT 'For the city ' || city || ', the highest rating is: ' || MAX(rating) AS result
FROM CUST
GROUP BY city;


#29.Display the totals of orders for each day and place the results in descending order.
SELECT odate, SUM(amt) AS total_amt
FROM ORDERS
GROUP BY odate
ORDER BY total_amt DESC;


#30.All combinations of salespeople and customers who shared a city. (ie same city).
SELECT s.sname, c.cname, s.city
FROM SALESPEOPLE s
JOIN CUST c ON s.city = c.city;


#31.Name of all customers matched with the salespeople serving them.
SELECT c.cname, s.sname
FROM CUST c
JOIN SALESPEOPLE s ON c.snum = s.snum;


#32.List each order number followed by the name of the customer who made the order.
SELECT o.onum, c.cname
FROM ORDERS o
JOIN CUST c ON o.cnum = c.cnum;


#33.Names of salesperson and customer for each order after the order number.
SELECT o.onum, s.sname, c.cname
FROM ORDERS o
JOIN SALESPEOPLE s ON o.snum = s.snum
JOIN CUST c ON o.cnum = c.cnum;


#34.Produce all customer serviced by salespeople with a commission above 12%.
SELECT * FROM CUST
WHERE snum IN (
  SELECT snum FROM SALESPEOPLE WHERE comm > 0.12
);


#35.Calculate the amount of the salesperson’s commission on each order with a rating above 100.
SELECT o.onum, o.amt * s.comm AS commission
FROM ORDERS o
JOIN CUST c ON o.cnum = c.cnum
JOIN SALESPEOPLE s ON o.snum = s.snum
WHERE c.rating > 100;


#36.Find all pairs of customers having the same rating.
SELECT A.cname AS Customer1, B.cname AS Customer2, A.rating
FROM CUST A, CUST B
WHERE A.rating = B.rating AND A.cnum <> B.cnum;

#37.Find all pairs of customers having the same rating, each pair coming once only.
SELECT A.cname AS Customer1, B.cname AS Customer2, A.rating
FROM CUST A, CUST B
WHERE A.rating = B.rating AND A.cnum < B.cnum;


#38.Policy is to assign three salesperson to each customers. Display all such combinations.
SELECT c.cname, s1.sname AS Salesperson1, s2.sname AS Salesperson2, s3.sname AS Salesperson3
FROM CUST c, SALESPEOPLE s1, SALESPEOPLE s2, SALESPEOPLE s3
WHERE s1.snum < s2.snum AND s2.snum < s3.snum;


#39.Display all customers located in cities where salesman serres has customer.
SELECT * FROM CUST
WHERE city IN (
  SELECT city FROM CUST WHERE snum = (
    SELECT snum FROM SALESPEOPLE WHERE sname = 'Serres'
  )
);


#40.Find all pairs of customers served by single salesperson.
SELECT A.cname AS Customer1, B.cname AS Customer2
FROM CUST A, CUST B
WHERE A.snum = B.snum AND A.cnum < B.cnum;


#41.Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
SELECT A.sname AS Salesperson1, B.sname AS Salesperson2
FROM SALESPEOPLE A, SALESPEOPLE B
WHERE A.city = B.city AND A.snum < B.snum;


#42.Produce all pairs of orders by given customer, names that customers and eliminates duplicates.
SELECT A.onum AS Order1, B.onum AS Order2, C.cname
FROM ORDERS A, ORDERS B, CUST C
WHERE A.cnum = B.cnum AND A.onum < B.onum AND A.cnum = C.cnum;


#43.Produce names and cities of all customers with the same rating as Hoffman.
SELECT cname, city FROM CUST
WHERE rating = (
  SELECT rating FROM CUST WHERE cname = 'Hoffman'
);


#44.Extract all the orders of Motika.
SELECT * FROM ORDERS
WHERE snum = (
  SELECT snum FROM SALESPEOPLE WHERE sname = 'Motika'
);


#45.All orders credited to the same salesperson who services Hoffman.
SELECT * FROM ORDERS
WHERE snum = (
  SELECT snum FROM CUST WHERE cname = 'Hoffman'
);


#46.All orders that are greater than the average for Oct 4.
SELECT * FROM ORDERS
WHERE amt > (
  SELECT AVG(amt) FROM ORDERS WHERE odate = '04-OCT-94'
);


#47.Find average commission of salespeople in london.
SELECT AVG(comm) AS avg_comm
FROM SALESPEOPLE
WHERE city = 'London';



#48.Find all orders attributed to salespeople servicing customers in london.
SELECT * FROM ORDERS
WHERE snum IN (
  SELECT snum FROM CUST WHERE city = 'London'
);


#49.Extract commissions of all salespeople servicing customers in London.
SELECT DISTINCT s.snum, s.comm
FROM SALESPEOPLE s
JOIN CUST c ON s.snum = c.snum
WHERE c.city = 'London';


#50.Find all customers whose cnum is 1000 above the snum of serres.
SELECT * FROM CUST
WHERE cnum = (
  SELECT snum + 1000 FROM SALESPEOPLE WHERE sname = 'Serres'
);


#51.Count the customers with rating  above San Jose’s average.
SELECT COUNT(*) 
FROM CUST 
WHERE rating > (
  SELECT AVG(rating) 
  FROM CUST 
  WHERE city = 'San Jose'
);


#52.Obtain all orders for the customer named Cisnerous. (Assume you don’t know his customer no. (cnum)).
SELECT * 
FROM ORDERS 
WHERE cnum = (
  SELECT cnum FROM CUST WHERE cname = 'Cisnerous'
);


#53.Produce the names and rating of all customers who have above average orders.
SELECT DISTINCT c.cname, c.rating
FROM CUST c
JOIN ORDERS o ON c.cnum = o.cnum
WHERE o.amt > (
  SELECT AVG(amt) FROM ORDERS
);


#54.Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
SELECT snum, SUM(amt) AS total_amt
FROM ORDERS
GROUP BY snum
HAVING SUM(amt) > (
  SELECT MAX(amt) FROM ORDERS
);


#55.Find all customers with order on 3rd Oct.
SELECT DISTINCT c.* 
FROM CUST c
JOIN ORDERS o ON c.cnum = o.cnum
WHERE o.odate = '03-OCT-94';


#56.Find names and numbers of all salesperson who have more than one customer.
SELECT s.snum, s.sname
FROM SALESPEOPLE s
JOIN CUST c ON s.snum = c.snum
GROUP BY s.snum, s.sname
HAVING COUNT(*) > 1;


#57.Check if the correct salesperson was credited with each sale.
SELECT *
FROM ORDERS o
JOIN CUST c ON o.cnum = c.cnum
WHERE o.snum != c.snum;


#58.Find all orders with above average amounts for their customers.
SELECT o.*
FROM ORDERS o
WHERE o.amt > (
  SELECT AVG(o2.amt)
  FROM ORDERS o2
  WHERE o2.cnum = o.cnum
);


#59.Find the sums of the amounts from order table grouped by date, eliminating all those dates where the sum was not at least 2000 above the maximum amount.
SELECT odate, SUM(amt) AS total_amt
FROM ORDERS
GROUP BY odate
HAVING SUM(amt) >= (
  SELECT MAX(amt) FROM ORDERS
) + 2000;


#60.Find names and numbers of all customers with ratings equal to the maximum for their city.
SELECT c1.cname, c1.cnum
FROM CUST c1
WHERE rating = (
  SELECT MAX(c2.rating) FROM CUST c2 WHERE c2.city = c1.city
);


#61.Find all salespeople who have customers in their cities who they don’t service. ( Both way using Join and Correlated subquery.)
SELECT DISTINCT s.*
FROM SALESPEOPLE s
JOIN CUST c ON s.city = c.city AND s.snum != c.snum;


#62.Extract cnum,cname and city from customer table if and only if one or more of the customers in the table are located in San Jose.
SELECT cnum, cname, city 
FROM CUST
WHERE EXISTS (
  SELECT 1 FROM CUST WHERE city = 'San Jose'
);


#63.Find salespeople no. who have multiple customers.
SELECT snum 
FROM CUST
GROUP BY snum
HAVING COUNT(*) > 1;


#64.Find salespeople number, name and city who have multiple customers.
SELECT s.snum, s.sname, s.city
FROM SALESPEOPLE s
JOIN CUST c ON s.snum = c.snum
GROUP BY s.snum, s.sname, s.city
HAVING COUNT(*) > 1;


#65.Find salespeople who serve only one customer.
SELECT s.snum, s.sname
FROM SALESPEOPLE s
JOIN CUST c ON s.snum = c.snum
GROUP BY s.snum, s.sname
HAVING COUNT(*) = 1;



#66.Extract rows of all salespeople with more than one current order.
SELECT s.*
FROM SALESPEOPLE s
JOIN ORDERS o ON s.snum = o.snum
GROUP BY s.snum, s.sname, s.city, s.comm
HAVING COUNT(*) > 1;


#67.Find all salespeople who have customers with a rating of 300. (use EXISTS)
SELECT *
FROM SALESPEOPLE s
WHERE EXISTS (
  SELECT 1 FROM CUST c 
  WHERE c.snum = s.snum AND c.rating = 300
);


#68.Find all salespeople who have customers with a rating of 300. (use Join).
SELECT DISTINCT s.*
FROM SALESPEOPLE s
JOIN CUST c ON s.snum = c.snum
WHERE c.rating = 300;


#69.Select all salespeople with customers located in their cities who are not assigned to them. (use EXISTS).
SELECT *
FROM SALESPEOPLE s
WHERE EXISTS (
  SELECT 1 FROM CUST c 
  WHERE c.city = s.city AND c.snum != s.snum
);


#70.Extract from customers table every customer assigned the a salesperson who currently has at least one other customer ( besides the customer being selected) with orders in order table.
SELECT *
FROM CUST c1
WHERE EXISTS (
  SELECT 1 FROM CUST c2
  JOIN ORDERS o ON c2.cnum = o.cnum
  WHERE c2.snum = c1.snum AND c2.cnum != c1.cnum
);


#71.Find salespeople with customers located in their cities ( using both ANY and IN).
SELECT * FROM SALESPEOPLE
WHERE city IN (
  SELECT city FROM CUST
);


#72.Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS)
SELECT * FROM SALESPEOPLE s
WHERE EXISTS (
  SELECT 1 FROM CUST c
  WHERE c.sname > s.sname
);


#73.Select customers who have a greater rating than any customer in rome.
SELECT * FROM CUST
WHERE rating > ANY (
  SELECT rating FROM CUST WHERE city = 'Rome'
);


#74.Select all orders that had amounts that were greater that atleast one of the orders from Oct 6th.
SELECT * FROM ORDERS
WHERE amt > ANY (
  SELECT amt FROM ORDERS WHERE odate = '06-OCT-94'
);


#75.Find all orders with amounts smaller than any amount for a customer in San Jose. (Both using ANY and without ANY)
SELECT * FROM ORDERS
WHERE amt < ANY (
  SELECT amt FROM ORDERS
  WHERE cnum IN (SELECT cnum FROM CUST WHERE city = 'San Jose')
);


#76.Select those customers whose ratings are higher than every customer in Paris. ( Using both ALL and NOT EXISTS).
SELECT * FROM CUST
WHERE rating > ALL (
  SELECT rating FROM CUST WHERE city = 'Paris'
);


#77.Select all customers whose ratings are equal to or greater than ANY of the Seeres.
SELECT * FROM CUST
WHERE rating >= ANY (
  SELECT rating FROM CUST WHERE snum = (
    SELECT snum FROM SALESPEOPLE WHERE sname = 'Serres'
  )
);


#78.Find all salespeople who have no customers located in their city. ( Both using ANY and ALL)
SELECT * FROM SALESPEOPLE
WHERE city NOT IN (
  SELECT city FROM CUST
);
SELECT * FROM SALESPEOPLE s
WHERE s.city <> ALL (
  SELECT c.city FROM CUST c WHERE c.snum = s.snum
);


#79.Find all orders for amounts greater than any for the customers in London.
SELECT * FROM ORDERS
WHERE amt > ANY (
  SELECT amt FROM ORDERS
  WHERE cnum IN (SELECT cnum FROM CUST WHERE city = 'London')
);


#80.Find all salespeople and customers located in london.
SELECT 'Salesperson' AS role, sname AS name, city
FROM SALESPEOPLE
WHERE city = 'London'
UNION
SELECT 'Customer' AS role, cname, city
FROM CUST
WHERE city = 'London';


#81.For every salesperson, dates on which highest and lowest orders were brought.
-- Highest orders:
SELECT snum, odate, MAX(amt) AS amount, 'Highest' AS type
FROM ORDERS
GROUP BY snum, odate
HAVING amt = (
  SELECT MAX(amt) FROM ORDERS o2 WHERE o2.snum = ORDERS.snum
)
UNION
-- Lowest orders:
SELECT snum, odate, MIN(amt) AS amount, 'Lowest' AS type
FROM ORDERS
GROUP BY snum, odate
HAVING amt = (
  SELECT MIN(amt) FROM ORDERS o2 WHERE o2.snum = ORDERS.snum
);


#82.List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have.
SELECT s.sname, s.city,
       CASE
         WHEN EXISTS (
           SELECT 1 FROM CUST c
           WHERE c.city = s.city AND c.snum = s.snum
         ) THEN 'Has customer in city'
         ELSE 'No customer in city'
       END AS status
FROM SALESPEOPLE s;



#83.Append strings to the selected fields, indicating weather or not a given salesperson was matched to a customer in his city.
SELECT s.sname || ' (' || 
       CASE
         WHEN EXISTS (
           SELECT 1 FROM CUST c
           WHERE c.city = s.city AND c.snum = s.snum
         ) THEN 'matched'
         ELSE 'not matched'
       END || ')' AS result
FROM SALESPEOPLE s;


#84.Create a union of two queries that shows the names, cities and ratings of all customers. Those with a rating of 200 or greater will also have the words ‘High Rating’, while the others will have the words ‘Low Rating’.
SELECT cname, city, rating, 'High Rating' AS status
FROM CUST
WHERE rating >= 200
UNION
SELECT cname, city, rating, 'Low Rating' AS status
FROM CUST
WHERE rating < 200;


#85.Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order.
SELECT s.sname AS name, s.snum AS number
FROM SALESPEOPLE s
WHERE s.snum IN (
  SELECT snum FROM ORDERS
  GROUP BY snum
  HAVING COUNT(*) > 1
)
UNION
SELECT c.cname AS name, c.cnum AS number
FROM CUST c
WHERE c.cnum IN (
  SELECT cnum FROM ORDERS
  GROUP BY cnum
  HAVING COUNT(*) > 1
)
ORDER BY name;


#86.Form a union of three queries. Have the first select the snums of all salespeople in San Jose, then second the cnums of all customers in San Jose and the third the onums of all orders on Oct. 3. Retain duplicates between the last two queries, but eliminates and redundancies between either of them and the first.
SELECT snum FROM SALESPEOPLE WHERE city = 'San Jose'
UNION
SELECT cnum FROM CUST WHERE city = 'San Jose'
UNION ALL
SELECT onum FROM ORDERS WHERE odate = '03-OCT-94';


#87.Produce all the salesperson in London who had at least one customer there.
SELECT DISTINCT s.*
FROM SALESPEOPLE s
JOIN CUST c ON s.snum = c.snum AND s.city = c.city
WHERE s.city = 'London';


#88.Produce all the salesperson in London who did not have customers there.
SELECT * FROM SALESPEOPLE s
WHERE city = 'London' AND NOT EXISTS (
  SELECT 1 FROM CUST c
  WHERE c.snum = s.snum AND c.city = 'London'
);


#We want to see salespeople matched to their customers without excluding those salesperson who were not currently assigned to any customers. (User OUTER join and UNION)
SELECT s.sname, c.cname
FROM SALESPEOPLE s
LEFT JOIN CUST c ON s.snum = c.snum
UNION
SELECT s.sname, NULL
FROM SALESPEOPLE s
WHERE s.snum NOT IN (SELECT snum FROM CUST);
