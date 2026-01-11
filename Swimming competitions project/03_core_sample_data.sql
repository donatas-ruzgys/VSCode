USE swimming;

-- =====================================
-- ADDRESSES
-- =====================================
INSERT INTO addresses (street, city, zip_code, country) VALUES
('Karaliaus Mindaugo pr. 50', 'Kaunas', '44333', 'Lithuania'),
('Ozo g. 18', 'Vilnius', '08243', 'Lithuania'),
('Dubysos g. 12', 'Klaipėda', '91181', 'Lithuania'),
('Taikos pr. 11', 'Šiauliai', '78134', 'Lithuania'),
('Respublikos g. 45', 'Panevėžys', '35172', 'Lithuania');

-- =====================================
-- POOLS
-- =====================================
INSERT INTO pools (name, length_m, lanes, address_id) VALUES
('Kaunas Aquatic Center', 25, 6, 1),
('Vilnius Lazdynai Pool', 25, 6, 2),
('Klaipėda Central Pool', 25, 6, 3);

-- =====================================
-- CLUBS
-- =====================================
INSERT INTO clubs (name, address_id) VALUES
('Kaunas Swimming Club', 1),
('Vilnius Aquatics', 2),
('Klaipėda Dolphins', 3),
('Panevėžys Sharks', 5),
('Šiauliai Barracudas', 4);

-- =====================================
-- PARTICIPANTS – MEN (10)
-- =====================================
INSERT INTO participants
(first_name, last_name, birth_date, gender, club_id, address_id, email)
VALUES
('AthleteM01','LT','2001-03-12','M',1,1,'m01@demo.lt'),
('AthleteM02','LT','2000-07-21','M',2,2,'m02@demo.lt'),
('AthleteM03','LT','1999-11-02','M',3,3,'m03@demo.lt'),
('AthleteM04','LT','2002-01-19','M',4,5,'m04@demo.lt'),
('AthleteM05','LT','1998-06-30','M',5,4,'m05@demo.lt'),
('AthleteM06','LT','2001-09-14','M',1,1,'m06@demo.lt'),
('AthleteM07','LT','2000-04-08','M',2,2,'m07@demo.lt'),
('AthleteM08','LT','1999-12-25','M',3,3,'m08@demo.lt'),
('AthleteM09','LT','2002-05-17','M',4,5,'m09@demo.lt'),
('AthleteM10','LT','1997-08-03','M',5,4,'m10@demo.lt');

-- =====================================
-- PARTICIPANTS – WOMEN (10 + 1 elite)
-- =====================================
INSERT INTO participants
(first_name, last_name, birth_date, gender, club_id, address_id, email)
VALUES
('AthleteF01','LT','2001-02-11','F',1,1,'f01@demo.lt'),
('AthleteF02','LT','2000-06-05','F',2,2,'f02@demo.lt'),
('AthleteF03','LT','1999-09-19','F',3,3,'f03@demo.lt'),
('AthleteF04','LT','2002-03-28','F',4,5,'f04@demo.lt'),
('AthleteF05','LT','1998-12-07','F',5,4,'f05@demo.lt'),
('AthleteF06','LT','2001-07-14','F',1,1,'f06@demo.lt'),
('AthleteF07','LT','2000-10-01','F',2,2,'f07@demo.lt'),
('AthleteF08','LT','1999-05-22','F',3,3,'f08@demo.lt'),
('AthleteF09','LT','2002-11-09','F',4,5,'f09@demo.lt'),
('AthleteF10','LT','1997-04-18','F',5,4,'f10@demo.lt'),

-- Elite athlete (public figure)
('Ruta','Meilutyte','1997-03-19','F',2,2,'ruta.meilutyte@elite.lt');

-- =====================================
-- COMPETITIONS
-- =====================================
INSERT INTO competitions (name, start_date, pool_id) VALUES
('Lithuanian Swimming Championship 2024', '2024-04-03', 1);
