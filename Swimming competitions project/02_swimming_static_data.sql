USE swimming;

-- =====================================
-- STYLES (World Aquatics standard)
-- =====================================
INSERT INTO styles (name) VALUES
('Freestyle'),
('Backstroke'),
('Breaststroke'),
('Butterfly'),
('Individual Medley');

-- =====================================
-- DISTANCES (common international distances, 25m pool)
-- =====================================
INSERT INTO distances (meters) VALUES
(50),
(100),
(200),
(400),
(800),
(1500);

-- =====================================
-- ROUNDS (competition stages)
-- =====================================
INSERT INTO rounds (name, round_order) VALUES
('Heats', 1),
('Semifinal', 2),
('Final', 3);

-- =====================================
-- AGE GROUPS
-- =====================================
INSERT INTO age_groups (name, min_age, max_age) VALUES
('Junior', 14, 17),
('Youth', 18, 20),
('Senior', 21, 99);

-- =====================================
-- COMPETITION GROUPS
-- (generated as age_group × gender)
-- =====================================
INSERT INTO competition_groups (age_group_id, gender) VALUES
-- Junior
(1, 'M'),
(1, 'F'),
-- Youth
(2, 'M'),
(2, 'F'),
-- Senior
(3, 'M'),
(3, 'F');
