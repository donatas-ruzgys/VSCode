-- =====================================
-- Sample Data for Swimming Competition
-- =====================================

-- ADDRESSES
INSERT INTO addresses (street, city, zip_code, country) VALUES
('123 Main St','Vilnius','LT-001', 'Lithuania'),
('456 Lake Rd','Kaunas','LT-502', 'Lithuania'),
('789 River St','Klaipeda','LT-901', 'Lithuania'),
('12 Ocean Ave','Palanga','LT-100', 'Lithuania'),
('34 Forest Rd','Siauliai','LT-400', 'Lithuania');

-- CLUBS
INSERT INTO clubs (name,address_id) VALUES
('Vilnius Swim Club',1),
('Kaunas Swim Team',2),
('Klaipeda Dolphins',3),
('Palanga Sharks',4),
('Siauliai Waves',5);

-- PARTICIPANTS
INSERT INTO participants (first_name,last_name,birth_date,gender,club_id,email) VALUES
('Jonas','Jonaitis','2008-05-12','M',1,'jonas@mail.com'),
('Petras','Petraitis','2007-08-20','M',2,'petras@mail.com'),
('Ona','Onaitė','2009-01-15','F',3,'ona@mail.com'),
('Ieva','Ievaitė','2008-03-22','F',4,'ieva@mail.com'),
('Tomas','Tomaitis','2006-12-10','M',5,'tomas@mail.com');

-- POOLS
INSERT INTO pools (name,length_m,lanes,address_id) VALUES
('Vilnius Pool',25,4,1),
('Kaunas Pool',25,4,2),
('Klaipeda Pool',25,6,3),
('Palanga Pool',25,4,4),
('Siauliai Pool',25,4,5);

-- COMPETITIONS
INSERT INTO competitions (name,start_date,pool_id) VALUES
('Vilnius Open 2025','2025-06-01',1),
('Kaunas Cup 2025','2025-06-15',2),
('Klaipeda Sprint 2025','2025-07-01',3),
('Palanga Swim Fest','2025-07-10',4),
('Siauliai Championship','2025-07-20',5);

-- AGE_GROUPS
INSERT INTO age_groups (name,min_age,max_age) VALUES
('Under 12',0,12),
('13-14',13,14),
('15-16',15,16),
('17-18',17,18),
('19+',19,99);

-- COMPETITION_GROUPS
INSERT INTO competition_groups (age_group_id,gender) VALUES
(1,'M'),(1,'F'),
(2,'M'),(2,'F'),
(3,'M'),(3,'F'),
(4,'M'),(4,'F'),
(5,'M'),(5,'F');

-- DISTANCES
INSERT INTO distances (meters) VALUES
(50),(100),(200),(400),(800);

-- STYLES
INSERT INTO styles (name) VALUES
('Freestyle'),('Backstroke'),('Breaststroke'),('Butterfly'),('Medley');

-- REGISTRATIONS
INSERT INTO registrations (participant_id,competition_id,style_id,distance_id,group_id,seed_time_seconds) VALUES
(1,1,1,1,3,60.50),
(2,1,1,1,3,62.00),
(3,1,1,1,2,65.30),
(4,1,1,1,2,66.10),
(5,1,1,1,4,58.20);

-- ROUNDS
INSERT INTO rounds (name,round_order) VALUES
('Heats',1),
('Semifinals',2),
('Final',3);

-- HEATS
INSERT INTO heats (competition_id,group_id,round_id,heat_number) VALUES
(1,3,1,1),
(1,3,1,2),
(1,2,1,1),
(1,2,1,2),
(1,4,1,1);

-- HEAT_ASSIGNMENTS
INSERT INTO heat_assignments (heat_id,registration_id,lane_number) VALUES
(1,1,1),
(1,2,2),
(2,3,1),
(2,4,2),
(5,5,1);

-- RESULTS
INSERT INTO results (heat_assignment_id,final_time_seconds,finish_position,disqualified) VALUES
(1,60.00,1,FALSE),
(2,62.50,2,FALSE),
(3,NULL,NULL,TRUE),
(4,66.50,2,FALSE),
(5,58.10,1,FALSE);

-- PARTICIPANT_ADDRESSES
INSERT INTO participant_addresses (participant_id,address_id,valid_from,valid_to) VALUES
(1,1,'2020-01-01',NULL),
(2,2,'2019-05-01',NULL),
(3,3,'2021-03-01',NULL),
(4,4,'2020-07-01',NULL),
(5,5,'2018-10-01',NULL);
