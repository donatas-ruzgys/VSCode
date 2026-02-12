-- 1. Nuomos pajamos pagal kategoriją ir šalį
-- • Sukurkite užklausą, kuri suskaičiuoja bendras nuomos pajamas pagal filmų
-- kategoriją ir kliento šalį.
-- • Power BI pavaizduokite naudodami stulpelinę diagramą ir filtrą pagal šalį.

SELECT
	c.name AS category_name,
    co.country AS customer_country,
    SUM(p.amount) AS total_rental_revenue
FROM
	payment p 
JOIN customer cu USING (customer_id)
JOIN address a USING (address_id)
JOIN city ci USING (city_id)
JOIN country co USING (country_id)
JOIN rental r USING (rental_id)
JOIN inventory i USING (inventory_id)
JOIN film_category fc USING (film_id)
JOIN category c USING (category_id)
GROUP BY category_name, customer_country;

-- 2. TOP 10 klientų pagal sumokėtą sumą
-- • Raskite 10 daugiausiai sumokėjusių klientų.
-- • Rodykite kliento vardą, el. paštą ir bendrą sumą.
-- • Power BI naudokite horizontalų bar chart.

SELECT
    CONCAT_WS(" ", c.first_name, c.last_name) AS customer_name,
    c.email,
    SUM(p.amount) AS total_paid
FROM payment p
JOIN customer c 
    ON p.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
ORDER BY
    total_paid DESC
LIMIT 10;

-- 3. Filmų populiarumas pagal nuomų skaičių
-- • Suskaičiuokite kiekvieno filmo nuomos skaičių.
-- • Rodykite filmo pavadinimą, nuomos skaičių, ir bendras pajamas.
-- • Atvaizduokite Power BI stulpelinėje diagramoje ar lentelėje.

SELECT
    f.title AS film_title,
    COUNT(r.rental_id) AS rental_count,
    SUM(p.amount) AS total_revenue
FROM rental r
JOIN inventory i 
    ON r.inventory_id = i.inventory_id
JOIN film f 
    ON i.film_id = f.film_id
LEFT JOIN payment p 
    ON r.rental_id = p.rental_id
GROUP BY
    f.film_id,
    f.title;


-- 4. Mėnesinės pajamos (trendas)
-- • Grupavimas pagal metus ir mėnesį.
-- • Rodykite mėnesines pajamas (mokėjimų suma).
-- • Naudokite linijinę diagramą (line chart) Power BI.

SELECT
    YEAR(p.payment_date) AS payment_year,
    MONTH(p.payment_date) AS payment_month,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY
    YEAR(p.payment_date),
    MONTH(p.payment_date);
-- ---------------------------------------------
SELECT
    DATE_FORMAT(p.payment_date, '%Y-%m-01') AS month_start,
    SUM(p.amount) AS monthly_revenue
FROM payment p
GROUP BY
    DATE_FORMAT(p.payment_date, '%Y-%m-01')
ORDER BY
    month_start;
    
-- 5. Darbuotojų veiklos analizė
-- • Suskaičiuokite, kiek kiekvienas darbuotojas surinko mokėjimų.
-- • Pavaizduokite Power BI naudodami donut chart ar bar chart.
    
SELECT
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    COUNT(p.payment_id) AS payments_count
FROM payment p
JOIN staff s 
    ON p.staff_id = s.staff_id
GROUP BY
    s.staff_id,
    s.first_name,
    s.last_name;
    
    
-- 6. Nuomos skaičius pagal parduotuvę ir miestą
-- • Raskite bendrą nuomų skaičių kiekvienai parduotuvei ir jos miestui.
-- • Jei įmanoma – naudokite žemėlapio vizualizaciją Power BI.

SELECT
    s.store_id,
    ci.city AS city,
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i 
    ON r.inventory_id = i.inventory_id
JOIN store s 
    ON i.store_id = s.store_id
JOIN address a 
    ON s.address_id = a.address_id
JOIN city ci 
    ON a.city_id = ci.city_id
GROUP BY
    s.store_id,
    ci.city;

-- 7. Aktyvūs vs neaktyvūs klientai
-- • Suskaičiuokite aktyvius ir neaktyvius klientus.
-- • Naudokite skritulinę diagramą (pie chart).

SELECT
    CASE 
        WHEN active = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS customer_status,
    COUNT(*) AS customer_count
FROM customer
GROUP BY
    active;

-- 8. Filmų trukmės pasiskirstymas
-- • Suskirstykite filmus į intervalus:
-- <60 min, 60–90 min, 90–120 min, >120 min.
-- • Pavaizduokite histogramoje arba stulpelinėje diagramoje.

SELECT
    CASE
        WHEN length < 60 THEN '< 60 min'
        WHEN length BETWEEN 60 AND 90 THEN '60–90 min'
        WHEN length BETWEEN 91 AND 120 THEN '90–120 min'
        ELSE '> 120 min'
    END AS duration_category,
    COUNT(*) AS film_count
FROM film
GROUP BY
    duration_category;


-- 9. Populiariausios filmų kategorijos
-- -- • Suskaičiuokite nuomos skaičių pagal kategoriją.
-- -- • Rodykite mažėjančia tvarka Power BI.
SELECT
    c.name AS category,
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i 
    ON r.inventory_id = i.inventory_id
JOIN film f 
    ON i.film_id = f.film_id
JOIN film_category fc 
    ON f.film_id = fc.film_id
JOIN category c 
    ON fc.category_id = c.category_id
GROUP BY
    c.category_id,
    c.name;

-- 10. Dieninės pajamos pasirinktą mėnesį
-- • Pasirinkite konkretų mėnesį (pvz., 2005 m. liepa).
-- • Rodykite dieninių pajamų trendą naudodami linijinę diagramą.
SELECT
    DATE(p.payment_date) AS payment_day,
    SUM(p.amount) AS daily_revenue
FROM payment p
WHERE
    p.payment_date >= '2005-07-01'
    AND p.payment_date < '2005-08-01'
GROUP BY
    DATE(p.payment_date);



