/*PROJECT MUSIC STORE LUKMAN ALFARIDZI*/

/*  Who is the senior most employee based on job title? */
SELECT TOP 1 title, first_name,last_name FROM employee
ORDER BY levels DESC

/* Q2: Which countries have the most Invoices? */
SELECT TOP 1 COUNT(*) AS total_invoice, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY total_invoice DESC

/* Q3: What are top 3 values of total invoice? */
SELECT TOP 3 total 
FROM invoice
ORDER BY total DESC

/* Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals */
SELECT TOP 1 billing_city,
       SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC 

/* Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/
SELECT TOP 1 customer.customer_id, first_name, last_name, SUM(total) AS total_spending 
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, first_name, last_name
ORDER BY total_spending DESC

/* Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */
SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)ORDER BY email;

/* Write a query that returns the Artist name and total track count of the top 10 rock bands. */
SELECT TOP 10 artist.artist_id, COUNT(CAST(COALESCE(track.album_id, '') AS INT)) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC;

/*Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;

/* Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent */
SELECT TOP 1 artist.artist_id, SUM(cast(invoice_line.unit_price AS DECIMAL) * invoice_line.quantity) 
AS total_sales FROM invoice_line
JOIN track ON track.track_id = invoice_line.track_id
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
GROUP BY artist.artist_id
ORDER BY total_sales DESC
    
/*  We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */
SELECT DISTINCT c.country, g.name AS genre
FROM customer c
	JOIN invoice i ON c.customer_id = i.customer_id
	JOIN invoice_line il ON i.invoice_id = il.invoice_id
	JOIN track t ON il.track_id = t.track_id
	JOIN genre g ON t.genre_id = g.genre_id
	JOIN (
SELECT c.country, g.name AS genre, COUNT(il.invoice_line_id) AS cnt
FROM customer c
	JOIN invoice i ON c.customer_id = i.customer_id
	JOIN invoice_line il ON i.invoice_id = il.invoice_id
	JOIN track t ON il.track_id = t.track_id
	JOIN genre g ON t.genre_id = g.genre_id
GROUP BY c.country, g.name) AS genre_counts ON c.country = genre_counts.country
	AND g.name = genre_counts.genre
	AND genre_counts.cnt = (
SELECT MAX(cnt) FROM (SELECT COUNT(il.invoice_line_id) AS cnt
FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
WHERE c.country = genre_counts.country
GROUP BY c.country, g.name ) AS counts) ORDER BY c.country;

/*Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */
SELECT c.country, c.customer_id,
  MAX(c.first_name) AS first_name,
  SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY
  c.country,
  c.customer_id
ORDER BY
  total_spent DESC;