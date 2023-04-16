select * from Album
select * from Artist
select * from Customer
select * from Employee
select * from Genre
select * from Invoice
select * from InvoiceLine
select * from MediaType
select * from Playlist
select * from PlaylistTrack
select * from Track

/*Question Set 1*/

-- Q.1 Who is the senior most employee based on job title?

select * from Employee
SELECT TOP 1 title, last_name, first_name 
FROM employee
ORDER BY levels DESC;


-- Q.2 Which Countries have the most Invoices?

select * from Invoice
SELECT COUNT(*) AS c, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY c DESC       

-- Q.3 What are top 3 values of total invoice?

select * from Invoice
SELECT TOP 3 total 
FROM invoice
ORDER BY total DESC

-- Q.4 Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.
--Write a query that returns one city that has the highest sum of invoice totals.
--Return both the city name & sum of all invoice totals

select * from Invoice
SELECT TOP 5 billing_city, SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC;

-- Q.5 Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.

select * from Customer
SELECT TOP 1 customer.customer_id, customer.first_name, customer.last_name, SUM(total) AS total_spending
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_spending DESC;

/*Question Set 2*/

-- Q.1 Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A.

select * from Genre
select * from Customer
SELECT DISTINCT email AS Email, first_name AS FirstName, last_name AS LastName, genre.name AS Name 
FROM customer 
JOIN invoice ON invoice.customer_id = customer.customer_id 
JOIN invoiceline ON invoiceline.invoice_id = invoice.invoice_id 
JOIN track ON track.track_id = invoiceline.track_id 
JOIN genre ON genre.genre_id = track.genre_id 
WHERE genre.name LIKE 'Rock' 
ORDER BY email;

-- Q.2 Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands.

select * from Artist
select * from Track
SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;

--Q.3 Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

select * from Track
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
    SELECT AVG(milliseconds) AS avg_track_length
    FROM track
)
ORDER BY milliseconds DESC;

/*Question Set 3*/

--Q.1 Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent?

select * from Customer
select * from Artist
WITH best_selling_artist AS (
	SELECT TOP 1 artist.artist_id AS artist_id, artist.name AS artist_name, SUM(InvoiceLine.unit_price*InvoiceLine.quantity) AS total_sales
	FROM InvoiceLine
	JOIN track ON track.track_id = InvoiceLine.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY artist.artist_id, artist.name
	ORDER BY SUM(InvoiceLine.unit_price*InvoiceLine.quantity) DESC
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN InvoiceLine il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, bsa.artist_name
ORDER BY SUM(il.unit_price*il.quantity) DESC;


-- Q.2 We want to find out the most popular music Genre for each country. 
--We determine the most popular genre as the genre with the highest amount of purchases. 
--Write a query that returns each country along with the top Genre. 
-- For countries where the maximum number of purchases is shared return all Genres.

select * from Invoice
select * from Genre
WITH sales_per_country AS (
    SELECT COUNT(*) AS purchases_per_genre, customer.country, genre.name, genre.genre_id
    FROM InvoiceLine
    JOIN invoice ON invoice.invoice_id = InvoiceLine.invoice_id
    JOIN customer ON customer.customer_id = invoice.customer_id
    JOIN track ON track.track_id = InvoiceLine.track_id
    JOIN genre ON genre.genre_id = track.genre_id
    GROUP BY customer.country, genre.name, genre.genre_id
), max_genre_per_country AS (
    SELECT MAX(purchases_per_genre) AS max_genre_number, country
    FROM sales_per_country
    GROUP BY country
)
SELECT spc.* 
FROM sales_per_country spc
JOIN max_genre_per_country mgpc ON spc.country = mgpc.country
AND spc.purchases_per_genre = mgpc.max_genre_number
ORDER BY spc.country, spc.purchases_per_genre DESC, spc.name;
