/* Q1: Who is the senior most employee based on job title? */

select * from employee
where levels = 'L7' and reports_to is null;

/* 2nd  Approach*/
select * from employee
order by levels Desc
limit 1;


/* Q2: Which countries have the most Invoices? */

select billing_country,count(billing_country) as Invoices  from invoice
group by billing_country
order by invoices desc;

/* Q3: What are top 3 values of total invoice? */

select total  from invoice
order by total desc
limit 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select billing_city , sum(total) as TotalSum from invoice
group by billing_city
order by TotalSum Desc
limit 1;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/



select c.customer_id, c.first_name, c.last_name,sum(total) as Total_spending from customer as c
Inner Join invoice as i on c.customer_id = i.customer_id
group by c.customer_id
order by Total_spending desc
limit 1;





/* Question Set 2 - Moderate 

Write query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A
*/


select Distinct email , first_name , last_name
from customer
join  invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in (
 select track_id from track
 join genre on track.genre_id = genre.genre_id
 where genre.name Like 'Rock'
 )
 order by email asc;


select artist.artist_id,artist.name , count(artist.artist_id) as number_of_songs from artist
join album on artist.artist_id = album.artist_id
join track on album.album_id = track.album_id
join genre on track.genre_id = genre.genre_id 
WHERE genre.name LIKE 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;


select track.name , milliseconds from track
where milliseconds >(
  select avg(milliseconds) from track 
)
order by milliseconds desc;