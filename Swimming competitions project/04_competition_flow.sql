USE swimming;

-- =====================================================
-- HELPER IDS (ASSUMED FROM PREVIOUS FILES)
-- Competition: id = 1
-- Styles:
--   Freestyle = 1
--   Breaststroke = 3
-- Distances:
--   50m = 1
--   100m = 2
-- Rounds:
--   Heats = 1
--   Semifinal = 2
--   Final = 3
-- Groups:
--   Senior Men = 5
--   Senior Women = 6
-- =====================================================

-- =====================================================
-- 1. REGISTRATIONS
-- =====================================================

-- Men – 100m Freestyle (10 swimmers)
INSERT INTO registrations
(participant_id, competition_id, style_id, distance_id, group_id, seed_time_seconds)
VALUES
(1,1,1,2,5,50.20),
(2,1,1,2,5,49.80),
(3,1,1,2,5,50.90),
(4,1,1,2,5,51.30),
(5,1,1,2,5,49.50),
(6,1,1,2,5,50.10),
(7,1,1,2,5,50.70),
(8,1,1,2,5,51.00),
(9,1,1,2,5,52.10),
(10,1,1,2,5,49.90);

-- Women – 50m Freestyle (10 swimmers)
INSERT INTO registrations
(participant_id, competition_id, style_id, distance_id, group_id, seed_time_seconds)
VALUES
(11,1,1,1,6,25.80),
(12,1,1,1,6,26.10),
(13,1,1,1,6,26.40),
(14,1,1,1,6,26.70),
(15,1,1,1,6,25.60),
(16,1,1,1,6,26.00),
(17,1,1,1,6,26.30),
(18,1,1,1,6,26.90),
(19,1,1,1,6,27.20),
(20,1,1,1,6,25.90);

-- Women – 50m Breaststroke (9 swimmers incl. Ruta)
INSERT INTO registrations
(participant_id, competition_id, style_id, distance_id, group_id, seed_time_seconds)
VALUES
(11,1,3,1,6,31.20),
(12,1,3,1,6,31.80),
(13,1,3,1,6,32.10),
(14,1,3,1,6,32.50),
(15,1,3,1,6,30.90),
(16,1,3,1,6,31.50),
(17,1,3,1,6,32.20),
(18,1,3,1,6,33.00),
(21,1,3,1,6,29.30); -- Ruta Meilutyte (elite)

-- =====================================================
-- 2. HEATS
-- =====================================================

-- MEN 100m FREESTYLE
-- Semifinals
INSERT INTO heats (competition_id, group_id, style_id, distance_id, round_id, heat_number)
VALUES
(1,5,1,2,2,1),
(1,5,1,2,2,2),
-- Final
(1,5,1,2,3,1);

-- WOMEN 50m FREESTYLE
INSERT INTO heats (competition_id, group_id, style_id, distance_id, round_id, heat_number)
VALUES
(1,6,1,1,2,1),
(1,6,1,1,2,2),
(1,6,1,1,3,1);

-- WOMEN 50m BREASTSTROKE
INSERT INTO heats (competition_id, group_id, style_id, distance_id, round_id, heat_number)
VALUES
(1,6,3,1,2,1),
(1,6,3,1,2,2),
(1,6,3,1,3,1);

-- =====================================================
-- 3. HEAT ASSIGNMENTS (SEMIFINALS)
-- =====================================================

-- Men SF1 & SF2
INSERT INTO heat_assignments (heat_id, registration_id, lane_number) VALUES
(1,1,4),(1,2,3),(1,3,5),(1,4,2),(1,5,6),
(2,6,4),(2,7,3),(2,8,5),(2,9,2),(2,10,6);

-- Women 50 Free SF
INSERT INTO heat_assignments (heat_id, registration_id, lane_number) VALUES
(4,11,4),(4,12,3),(4,13,5),(4,14,2),(4,15,6),
(5,16,4),(5,17,3),(5,18,5),(5,19,2),(5,20,6);

-- Women 50 Breast SF
INSERT INTO heat_assignments (heat_id, registration_id, lane_number) VALUES
(7,11,5),(7,12,3),(7,13,2),(7,14,6),
(8,15,5),(8,16,3),(8,17,2),(8,21,4); -- Ruta

-- =====================================================
-- 4. FINAL ASSIGNMENTS
-- =====================================================

-- Men Final (top 6)
INSERT INTO heat_assignments (heat_id, registration_id, lane_number) VALUES
(3,5,4),(3,2,3),(3,10,5),(3,1,2),(3,6,6),(3,3,1);

-- Women 50 Free Final
INSERT INTO heat_assignments (heat_id, registration_id, lane_number) VALUES
(6,15,4),(6,11,3),(6,20,5),(6,16,2),(6,12,6),(6,13,1);

-- Women 50 Breast Final (Ruta dominates)
INSERT INTO heat_assignments (heat_id, registration_id, lane_number) VALUES
(9,21,4),(9,15,3),(9,11,5),(9,16,2),(9,12,6),(9,13,1);

-- =====================================================
-- 5. RESULTS (FINALS)
-- =====================================================

-- Men 100m Freestyle
INSERT INTO results (heat_assignment_id, final_time_seconds, finish_position) VALUES
(21,49.20,1),
(22,49.60,2),
(23,49.80,3),
(24,50.10,4),
(25,50.30,5),
(26,50.90,6);

-- Women 50m Freestyle
INSERT INTO results (heat_assignment_id, final_time_seconds, finish_position) VALUES
(27,25.40,1),
(28,25.70,2),
(29,25.90,3),
(30,26.10,4),
(31,26.30,5),
(32,26.60,6);

-- Women 50m Breaststroke (elite)
INSERT INTO results (heat_assignment_id, final_time_seconds, finish_position) VALUES
(33,29.05,1), -- Ruta Meilutyte
(34,30.70,2),
(35,31.10,3),
(36,31.40,4),
(37,31.90,5),
(38,32.20,6);
