#2
#a All inexpensive Tshirts sold in California to young people
select S.city, I.color, C.cName, F.price
    from Sales F, Store S, Item I, Customer C
    where F.storeID = S.storeID and F.itemID = I.itemID 
    and F.custID = C.custID and S.state = 'CA' 
    and I.category = 'Tshirt' and C.age < 22 and F.price < 25;
  
#b Total sales by store ID and customer name
select storeID, cName, sum(price)
	from Sales s, Customer c
	where s.custID=c.custID
	group by storeID, cName;

#c Drill-down Total sales by store ID, category, and customer
select storeID, i.category, cName, sum(price)
	from Sales s, Customer c, Item i
	where s.custID=c.custID and s.itemID=i.itemID
	group by storeID, i.category, cName;
    
#d "Slice" Total sales by store ID, category, and customer for "store6" only
select s.storeID, i.category, cName, sum(price)
	from Sales s, Customer c, Item i, Store t
	where s.custID=c.custID and s.itemID=i.itemID
	and s.storeID=t.storeID and t.storeId ='store6'
	group by storeID, i.category, cName;
    
#e "Dice" Total sales by store ID, category, and customer for "store6" and "Jacket" only
select s.storeID, i.category, cName, sum(price)
	from Sales s, Customer c, Item i, Store t
	where s.custID=c.custID and s.itemID=i.itemID
	and s.storeID=t.storeID and t.storeId ='store6' and i.category='Jacket'
	group by storeID, i.category, cName;
    
#f Roll-up Total sales by category
select i.category, sum(price)
	from Sales s, Customer c, Item i, Store t
	where s.custID=c.custID and s.itemID=i.itemID and s.storeID=t.storeID
	group by i.category;
    
#g Total sales by state, county, city
select state, county, city, sum(price)
	from Sales F, Store S
	where F.storeID = S.storeID
	group by state, county, city;
    
#h Total sales by state, county, city with rollup
select state, county, city, sum(price)
	from Sales F, Store S
	where F.storeID = S.storeID
	group by state, county, city with rollup;


#3
#a List total sales by state of store and age of customer
SELECT state, age, sum(price) FROM Sales F, Store S, Customer C
WHERE F.storeID = S.storeID AND F.custID = C.custID
GROUP BY state, age;

#b Drill down to items by item color (on the basis of the previous query)
SELECT state, age, I.color, sum(price) 
FROM Sales F, Store S, Customer C, Item I
WHERE F.storeID = S.storeID AND F.custID = C.custID 
AND F.itemID = I.itemID
GROUP BY state, age, I.color;

#c Use "with rollup" with the previous query
# (for the rollup rows the output must match the result of query a)
SELECT state, age, I.color, sum(price) 
FROM Sales F, Store S, Customer C, Item I
WHERE F.storeID = S.storeID AND F.custID = C.custID 
AND F.itemID = I.itemID
GROUP BY state, age, I.color WITH ROLLUP;

#d Slice by listing only items with blue color (on the basis of query b)
SELECT state, age, I.color, sum(price) 
FROM Sales F, Store S, Customer C, Item I
WHERE F.storeID = S.storeID AND F.custID = C.custID 
AND F.itemID = I.itemID AND I.color = 'blue'
GROUP BY state, age, I.color;

#e Rollup total sales by customer age and item color (on the basis of query b)
# [the remaining dimensions are customer age and item color]
SELECT age, I.color, sum(price) 
FROM Sales F, Store S, Customer C, Item I
WHERE F.storeID = S.storeID AND F.custID = C.custID 
AND F.itemID = I.itemID
GROUP BY age, I.color;
