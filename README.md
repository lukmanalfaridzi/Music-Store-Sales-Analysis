# Music-Store-Sales-Analysis

This project contains a set of queries that can be used to analyze data from a music store. The queries are designed to answer a variety of questions about the store's customers, sales, and inventory.

## Queries
The following is a list of the queries that are included in this project:
* **Who is the senior most employee based on job title?**
* **Which countries have the most Invoices?**
* **What are top 3 values of total invoice?**
* **Which city has the best customers?**
* **Who is the best customer?**
* **Write query to return the email, first name, last name, & Genre of all Rock Music listeners.**
* **Write a query that returns the Artist name and total track count of the top 10 rock bands.**
* **Return all the track names that have a song length longer than the average song length.**
* **Find how much amount spent by each customer on artists?**
* **We want to find out the most popular music Genre for each country.**
* **Write a query that determines the customer that has spent the most on music for each country.**

## How to Use
To use the queries in this project, you will need to have a database with the music store data loaded into it. Once you have the database loaded, you can use the following steps to run the queries:
1. Open a terminal window and navigate to the directory where the queries are located.
2. Run the following command to create a database connection:
mysql -u <username> -p <database_name>
```
3. Once you are connected to the database, you can run the queries by typing the following command:

```
mysql <query_file>
For example, to run the query that returns the senior most employee, you would type the following command:
mysql senior_most_employee.sql


## Notes
The queries in this project are designed to be used with a specific database schema. If you are using a different database schema, you may need to modify the queries to make them work.
